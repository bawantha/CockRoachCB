# Implementation Plan: Universal Clipboard Sync

## Overview

Incremental implementation of the Universal Clipboard Sync Flutter app. Each task builds on the previous, ending with full integration. All services are wired through `AppController`. Property-based tests use `fast_check`.

## Tasks

- [ ] 1. Flutter project setup and dependency configuration
  - Create Flutter project targeting Android, iOS, macOS, Windows, Linux
  - Add dependencies to `pubspec.yaml`: `firebase_core`, `firebase_auth`, `cloud_firestore`, `clipshare_clipboard_listener: ^1.2.14`, `super_clipboard` (latest), `tray_manager: ^0.2.0`, `window_manager`, `flutter_foreground_task`, `pointycastle`, `fast_check`, `device_info_plus`, `connectivity_plus`
  - Configure `AndroidManifest.xml`: foreground service permission, `FOREGROUND_SERVICE_TYPE_DATA_SYNC`, internet permission
  - Configure `Info.plist` (iOS): `NSPasteboardUsageDescription`
  - Configure macOS entitlements: `com.apple.security.network.client`, pasteboard access
  - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS/macOS) placeholders
  - Initialize Firebase in `main.dart` with `Firebase.initializeApp()`
  - _Requirements: 1.1, 2.2, 2.3, 8.1, 8.3_

- [ ] 2. Data models
  - [ ] 2.1 Implement `ClipboardEntry`, `ClipboardEntryMeta`, `EncryptedEntry`, `DeviceInfo`, `OfflineQueue` in `lib/models/`
    - `ClipboardEntry`: id, type (`ClipboardContentType` enum), `Uint8List? content`, deviceId, timestamp
    - `ClipboardEntryMeta`: id, type, preview (String), deviceId, timestamp
    - `EncryptedEntry`: id, userId, deviceId, timestamp, iv (`Uint8List` 12 bytes), ciphertext (`Uint8List`), type; include `toFirestore()` / `fromFirestore()` serialization
    - `DeviceInfo`: deviceId, platform, deviceName, registeredAt, lastActiveAt, isRevoked; include Firestore serialization
    - `OfflineQueue`: `List<ClipboardEntry> pending` (max 20), `bool get isFull`
    - _Requirements: 2.4, 3.2, 3.3, 4.6, 5.1, 5.5, 6.2, 7.4_

  - [ ]* 2.2 Write property test for `ClipboardEntryMeta` preview truncation (Property 18)
    - **Property 18: Text preview is truncated to 200 characters**
    - **Validates: Requirements 5.5**
    - Generate strings of random length; assert `preview.length <= 200`

  - [ ]* 2.3 Write property test for `OfflineQueue` cap (Property 24)
    - **Property 24: Queue is capped at 20 entries**
    - **Validates: Requirements 7.4**
    - Generate sequences of > 20 entries; assert `pending.length == 20` and oldest are dropped

- [ ] 3. AuthService implementation
  - [ ] 3.1 Implement `AuthService` abstract class and `FirebaseAuthService` in `lib/services/auth_service.dart`
    - `register(email, password)` → `FirebaseAuth.instance.createUserWithEmailAndPassword`
    - `signIn(email, password)` → `FirebaseAuth.instance.signInWithEmailAndPassword`
    - `signOut()` → `FirebaseAuth.instance.signOut()`
    - `sendPasswordReset(email)` → `FirebaseAuth.instance.sendPasswordResetEmail`
    - `authStateChanges` → `FirebaseAuth.instance.authStateChanges()`
    - `currentUserId` → `FirebaseAuth.instance.currentUser?.uid`
    - Map `FirebaseAuthException` codes (`email-already-in-use`, `wrong-password`, `user-not-found`) to typed errors
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7_

  - [ ]* 3.2 Write property test for invalid credentials (Property 2)
    - **Property 2: Invalid credentials never establish a session**
    - **Validates: Requirements 1.6**
    - Generate random email/password pairs not matching any registered account; assert `currentUserId == null` after failed sign-in

  - [ ]* 3.3 Write unit tests for `AuthService`
    - Successful registration, successful sign-in, sign-out clears `currentUserId`, duplicate email error, invalid credentials error
    - _Requirements: 1.1, 1.2, 1.4, 1.5, 1.6_

- [ ] 4. EncryptionService implementation
  - [ ] 4.1 Implement `EncryptionService` abstract class and `PointyCastleEncryptionService` in `lib/services/encryption_service.dart`
    - `initKey(userId, password)`: derive 32-byte key via PBKDF2-SHA256, 100,000 iterations, salt = `utf8.encode(userId)`; store key in memory only
    - `encrypt(entry)`: generate 12-byte random IV, AES-256-GCM encrypt `entry.content`, return `EncryptedEntry`; null `entry.content` after use
    - `decrypt(encryptedEntry)`: AES-256-GCM decrypt using stored key + IV; on `InvalidCipherTextException` discard and log, never expose ciphertext
    - `clearKey()`: zero-fill and release key bytes
    - Reject `initKey` if password is empty (throw `ArgumentError`)
    - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6_

  - [ ]* 4.2 Write property test for encryption round trip (Property 8)
    - **Property 8: Encryption round trip**
    - **Validates: Requirements 3.7, 3.2, 3.4**
    - Generate random `ClipboardEntry` values; assert `decrypt(encrypt(entry)).content` equals original bytes

  - [ ]* 4.3 Write property test for unique IV per encryption (Property 9)
    - **Property 9: Each encryption produces a unique IV**
    - **Validates: Requirements 3.3**
    - Encrypt same content twice; assert `iv1 != iv2`

  - [ ]* 4.4 Write property test for key derivation determinism (Property 7)
    - **Property 7: E2E key derivation is deterministic**
    - **Validates: Requirements 3.1**
    - Generate random userId/password pairs; derive key twice; assert byte-for-byte equal

  - [ ]* 4.5 Write property test for safe decryption failure (Property 10)
    - **Property 10: Decryption failure is handled safely**
    - **Validates: Requirements 3.6**
    - Generate tampered ciphertexts (flip random bytes); assert `decrypt` returns error and does not expose ciphertext

  - [ ]* 4.6 Write unit tests for `EncryptionService`
    - Key derivation with known test vectors, encrypt output differs from plaintext, decrypt of tampered data throws, empty password rejected
    - _Requirements: 3.1, 3.2, 3.6_

- [ ] 5. Checkpoint — Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 6. ClipboardMonitor implementation
  - [ ] 6.1 Implement `ClipboardMonitor` abstract class in `lib/services/clipboard_monitor.dart`
    - Define `Stream<ClipboardEntry> get onClipboardChanged`, `Future<void> writeToClipboard(ClipboardEntry)`, `void suppressNextChange()`, `void dispose()`
    - _Requirements: 2.1_

  - [ ] 6.2 Implement `NativeClipboardMonitor` (Android, macOS, Windows, Linux)
    - Mix in `ClipboardListener`, implement `onClipboardChanged` callback
    - On change: compare content to last captured; if identical skip (dedup); if > 5 MB discard and notify; else emit `ClipboardEntry`
    - `suppressNextChange()`: set `_suppress = true`; on next event if `_suppress` is true, clear flag and skip emit
    - `writeToClipboard`: call `suppressNextChange()` then `SystemClipboard.instance.write()`
    - _Requirements: 2.2, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11_

  - [ ] 6.3 Implement `IosClipboardMonitor` (iOS)
    - `Timer.periodic(Duration(seconds: 1))` calling `SystemClipboard.instance.read()`
    - Same dedup, size-limit, and suppression logic as `NativeClipboardMonitor`
    - Pause timer on `AppLifecycleState.paused`, resume on `AppLifecycleState.resumed`
    - _Requirements: 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10, 2.11_

  - [ ] 6.4 Add platform factory: `ClipboardMonitor.create()` returns `IosClipboardMonitor` on iOS, `NativeClipboardMonitor` otherwise
    - _Requirements: 2.1_

  - [ ]* 6.5 Write property test for clipboard change produces entry (Property 3)
    - **Property 3: Clipboard change produces a ClipboardEntry**
    - **Validates: Requirements 2.4, 2.5, 2.6, 2.7**
    - Generate random text/html/image content; inject into monitor; assert matching entry emitted

  - [ ]* 6.6 Write property test for duplicate suppression (Property 4)
    - **Property 4: Duplicate clipboard content is suppressed**
    - **Validates: Requirements 2.8**
    - Set same content twice; assert exactly one entry emitted

  - [ ]* 6.7 Write property test for oversized content rejection (Property 5)
    - **Property 5: Oversized content is rejected**
    - **Validates: Requirements 2.9**
    - Generate content > 5 MB; assert no entry emitted and notification fired

  - [ ]* 6.8 Write property test for write-then-no-capture suppression (Property 6)
    - **Property 6: Write-then-no-capture suppression**
    - **Validates: Requirements 2.11**
    - Write entry via `writeToClipboard`; assert no entry emitted on `onClipboardChanged`

  - [ ]* 6.9 Write unit tests for `ClipboardMonitor`
    - iOS timer starts/stops with app lifecycle, suppression flag prevents re-emit
    - _Requirements: 2.3, 2.11_

- [ ] 7. OfflineQueue implementation
  - [ ] 7.1 Implement `OfflineQueue` with persistence in `lib/services/offline_queue.dart`
    - Persist queue to local storage (`shared_preferences` or `hive`) so entries survive app restart
    - `enqueue(entry)`: if `isFull`, drop oldest entry and notify user; append new entry
    - `flush()`: return entries in ascending timestamp order, clear queue
    - _Requirements: 7.1, 7.2, 7.4_

  - [ ]* 7.2 Write property test for offline entries queued (Property 22)
    - **Property 22: Offline entries are queued**
    - **Validates: Requirements 7.1**
    - Simulate offline state; generate entries; assert all appear in `pending`

  - [ ]* 7.3 Write property test for queue upload preserves order (Property 23)
    - **Property 23: Queue upload preserves chronological order**
    - **Validates: Requirements 7.2**
    - Generate random-length queues; flush; assert ascending timestamp order

- [ ] 8. SyncService implementation
  - [ ] 8.1 Implement `SyncService` abstract class and `FirestoreSyncService` in `lib/services/sync_service.dart`
    - `upload(encryptedEntry)`: write to `users/{userId}/entries/{entryId}` in Firestore; on failure enqueue in `OfflineQueue`
    - `incomingEntries`: `Stream` from `Firestore.collection('users/{userId}/entries').snapshots()` filtered to exclude `deviceId == currentDeviceId`
    - `deleteEntry(entryId)`: delete Firestore document
    - `dispose()`: cancel Firestore listener subscription
    - On connectivity restore (`connectivity_plus`): call `OfflineQueue.flush()` and upload in order
    - _Requirements: 4.1, 4.2, 4.4, 4.5, 4.6, 7.1, 7.2_

  - [ ]* 8.2 Write property test for self-originated entries discarded (Property 12)
    - **Property 12: Self-originated entries are discarded**
    - **Validates: Requirements 4.5**
    - Generate entries with `deviceId == currentDeviceId`; assert none written to clipboard

  - [ ]* 8.3 Write property test for uploaded entries carry device ID and timestamp (Property 13)
    - **Property 13: Uploaded entries carry device ID and timestamp**
    - **Validates: Requirements 4.6**
    - Generate random entries; upload; inspect Firestore document; assert non-null deviceId and timestamp within clock skew

  - [ ]* 8.4 Write unit tests for `SyncService`
    - Self-device filter, Firestore listener wiring, offline queue flush order
    - _Requirements: 4.5, 7.2_

- [ ] 9. HistoryService implementation
  - [ ] 9.1 Implement `HistoryService` abstract class and `FirestoreHistoryService` in `lib/services/history_service.dart`
    - `history`: in-memory `List<ClipboardEntryMeta>` capped at 50, sorted descending by timestamp
    - `addEntry(meta)`: prepend to list; if length > 50 remove last
    - `fetchFullContent(entryId)`: fetch `EncryptedEntry` from Firestore, decrypt via `EncryptionService`, return `ClipboardEntry`; release bytes after return
    - `deleteEntry(entryId)`: remove from local list and delete Firestore document
    - `restoreFromRemote()`: query Firestore for latest 50 entries, decrypt metadata, populate `history`
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 5.6_

  - [ ]* 9.2 Write property test for history capped at 50 (Property 14)
    - **Property 14: History is capped at 50 entries**
    - **Validates: Requirements 5.1**
    - Generate sequences of > 50 additions; assert `history.length <= 50`

  - [ ]* 9.3 Write property test for history reverse chronological order (Property 15)
    - **Property 15: History is in reverse chronological order**
    - **Validates: Requirements 5.2**
    - Generate random entry sequences; assert `history[i].timestamp >= history[i+1].timestamp` for all i

  - [ ]* 9.4 Write property test for deleted entry absent (Property 17)
    - **Property 17: Deleted entry is absent from history and Firestore**
    - **Validates: Requirements 5.4**
    - Generate entries, delete one, assert absent from `history` and Firestore query

  - [ ]* 9.5 Write unit tests for `HistoryService`
    - Restore from Firestore, delete propagates to Firestore, 50-entry cap eviction
    - _Requirements: 5.1, 5.4, 5.6_

- [ ] 10. Checkpoint — Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 11. DeviceManager implementation
  - [ ] 11.1 Implement `DeviceManager` abstract class and `FirestoreDeviceManager` in `lib/services/device_manager.dart`
    - `registerDevice()`: write `DeviceInfo` to `users/{userId}/devices/{deviceId}` on first sign-in (check if doc exists first)
    - `devices`: `Stream<List<DeviceInfo>>` from Firestore real-time listener on `users/{userId}/devices`
    - `revokeDevice(deviceId)`: set `isRevoked = true` on Firestore document
    - `currentDeviceId`: stable UUID stored in `shared_preferences`, generated once on first launch
    - Listen to own device document; if `isRevoked == true` call `AuthService.signOut()` within 30 s
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

  - [ ]* 11.2 Write property test for revoked device stops receiving entries (Property 21)
    - **Property 21: Revoked device stops receiving entries**
    - **Validates: Requirements 6.3**
    - Revoke device; assert subsequent Firestore entries not delivered to its `SyncService` listener

  - [ ]* 11.3 Write unit tests for `DeviceManager`
    - First-sign-in registration, revocation removes from group, self-revocation triggers sign-out
    - _Requirements: 6.3, 6.4, 6.5_

- [ ] 12. AppController wiring
  - [ ] 12.1 Implement `AppController` in `lib/app_controller.dart`
    - Instantiate and hold references to `AuthService`, `ClipboardMonitor`, `EncryptionService`, `SyncService`, `HistoryService`, `DeviceManager`
    - On `authStateChanges` sign-in: call `EncryptionService.initKey`, `DeviceManager.registerDevice`, `SyncService` start, `HistoryService.restoreFromRemote`, `ClipboardMonitor` start
    - On `authStateChanges` sign-out: call `EncryptionService.clearKey`, `SyncService.dispose`, `ClipboardMonitor.dispose`
    - Subscribe to `ClipboardMonitor.onClipboardChanged` → `EncryptionService.encrypt` → `SyncService.upload` → `HistoryService.addEntry`
    - Subscribe to `SyncService.incomingEntries` → `EncryptionService.decrypt` → `ClipboardMonitor.writeToClipboard` → `HistoryService.addEntry`
    - _Requirements: 1.3, 1.4, 3.1, 4.1, 4.2, 4.3, 5.1_

  - [ ]* 12.2 Write property test for sign-out terminates session (Property 1)
    - **Property 1: Sign-out terminates session**
    - **Validates: Requirements 1.4**
    - Sign out; assert `AuthService.currentUserId == null` and `SyncService.incomingEntries` emits nothing further

  - [ ]* 12.3 Write property test for received entry written to clipboard (Property 11)
    - **Property 11: Received entry is written to clipboard**
    - **Validates: Requirements 4.3**
    - Inject `EncryptedEntry` from different device into `SyncService` stream; assert content appears in system clipboard

- [ ] 13. TrayManager and window_manager (desktop)
  - [ ] 13.1 Implement `TrayManager` in `lib/platform/tray_manager.dart` (platform-guarded: desktop only)
    - `init()`: set tray icon and register context menu (Open, Sync Status, Sign Out, Quit)
    - `updateSyncStatus(SyncStatus)`: update tray tooltip/menu item text
    - Register `WindowListener.onWindowClose` via `window_manager` to call `WindowManager.instance.hide()` instead of closing
    - On app start (desktop): call `WindowManager.instance.hide()` to start with no window shown
    - Wire "Sign Out" to `AppController`, "Quit" to `SyncService.dispose()` then `exit(0)`
    - _Requirements: 8.1, 8.2_

  - [ ]* 13.2 Write property test for sync continues while window hidden (Property 25)
    - **Property 25: Sync continues while tray window is hidden**
    - **Validates: Requirements 8.2**
    - Hide window; generate sync operations; assert operations complete identically to window-visible state

  - [ ]* 13.3 Write unit tests for `TrayManager`
    - Menu items trigger correct actions, window hide on close
    - _Requirements: 8.1, 8.2_

- [ ] 14. AndroidBackgroundService
  - [ ] 14.1 Implement `AndroidBackgroundService` in `lib/platform/android_background_service.dart` (platform-guarded: Android only)
    - Configure `FlutterForegroundTask.init(...)` with `channelId: 'clipboard_sync'`, `channelName: 'Clipboard Sync'`, `NotificationChannelImportance.LOW`, `autoRunOnBoot: true`, `interval: 0`
    - `start()`: call `FlutterForegroundTask.startService(notificationTitle: 'Clipboard Sync Active', ...)`
    - `stop()`: call `FlutterForegroundTask.stopService()`
    - Instantiate `ClipboardMonitor` and `SyncService` inside the foreground task handler
    - Wire `AppController` to call `start()` on sign-in and `stop()` on sign-out
    - _Requirements: 8.3, 8.7_

  - [ ]* 14.2 Write unit tests for `AndroidBackgroundService`
    - Service starts on sign-in, stops on sign-out, notification content correct
    - _Requirements: 8.3_

- [ ] 15. iOS foreground-only handling
  - [ ] 15.1 Add iOS foreground limitation banner in `lib/platform/ios_foreground_banner.dart`
    - Display informational `Banner` or `SnackBar` widget on iOS informing user that sync is foreground-only
    - Show banner once per session on app launch on iOS
    - _Requirements: 8.4_

- [ ] 16. UI screens
  - [ ] 16.1 Implement `AuthScreen` in `lib/ui/auth_screen.dart`
    - Email + password fields, Sign In button, Register button, Forgot Password link
    - Display typed error messages from `AuthService` (email in use, invalid credentials)
    - On success navigate to `HistoryScreen`
    - _Requirements: 1.1, 1.2, 1.5, 1.6, 1.7_

  - [ ] 16.2 Implement `HistoryScreen` in `lib/ui/history_screen.dart`
    - `ListView` of `ClipboardEntryMeta` from `HistoryService.history`, most recent first
    - Each item: preview text (truncated 200 chars) or image thumbnail, device name, timestamp
    - Tap item → `HistoryService.fetchFullContent` → `ClipboardMonitor.writeToClipboard`
    - Swipe-to-delete → `HistoryService.deleteEntry`
    - Offline mode indicator (banner/icon) driven by `connectivity_plus`
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5, 7.3_

  - [ ] 16.3 Implement `DeviceManagementScreen` in `lib/ui/device_management_screen.dart`
    - `StreamBuilder` on `DeviceManager.devices`
    - Each item: platform name, device name, last-active timestamp
    - Revoke button → `DeviceManager.revokeDevice(deviceId)` (disabled for current device)
    - _Requirements: 6.1, 6.2, 6.3_

- [ ] 17. Firestore security rules
  - [ ] 17.1 Write `firestore.rules` at project root
    - `users/{userId}/entries/{entryId}`: read/write only if `request.auth.uid == userId` and device not revoked
    - `users/{userId}/devices/{deviceId}`: read/write only if `request.auth.uid == userId`
    - Deny all other access
    - _Requirements: 3.5, 6.3_

- [ ] 18. Checkpoint — Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 19. Integration tests (Firestore emulator)
  - [ ]* 19.1 Write integration test: full outbound flow
    - Clipboard change → encrypt → Firestore write (Firestore emulator); assert document exists with correct fields
    - _Requirements: 4.1, 4.6_

  - [ ]* 19.2 Write integration test: full inbound flow
    - Write `EncryptedEntry` to Firestore emulator → decrypt → assert content written to clipboard
    - _Requirements: 4.2, 4.3_

  - [ ]* 19.3 Write integration test: history restore
    - Write entries to Firestore emulator, restart `HistoryService`, call `restoreFromRemote()`, assert history matches
    - _Requirements: 5.6_

  - [ ]* 19.4 Write integration test: device revocation rejects writes
    - Revoke device via Firestore emulator; attempt Firestore write from revoked device; assert security rules reject it
    - _Requirements: 6.3, 6.4_

- [ ] 20. Final checkpoint — Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for a faster MVP
- Each task references specific requirements for traceability
- Property tests use `fast_check` with a minimum of 100 iterations per property; each test includes the comment tag `// Feature: universal-clipboard-sync, Property N: <property_text>`
- `ClipboardMonitor.create()` factory handles platform selection at runtime; all other services are platform-agnostic
- `TrayManager` and `AndroidBackgroundService` are instantiated only on their respective platforms via `Platform.isDesktop` / `Platform.isAndroid` guards
- `EncryptedEntry.content` bytes are nulled immediately after `EncryptionService.encrypt()` returns to satisfy the memory footprint requirement (8.6)
