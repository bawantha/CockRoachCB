# Requirements Document

## Introduction

Universal Clipboard Sync is a cross-platform Flutter application that automatically synchronizes clipboard content across a user's authenticated devices in real-time. Supported platforms are Android, iOS, macOS, Linux, and Windows. All clipboard content is end-to-end encrypted before leaving the device, ensuring that neither the server nor Firebase can read the user's clipboard data. Only devices authenticated under the same account can decrypt and access the content.

## Glossary

- **App**: The Universal Clipboard Sync Flutter application running on any supported platform.
- **User**: A person who has registered and authenticated with the App.
- **Device**: A physical or virtual machine running the App and authenticated as a User.
- **Device_Group**: The set of all Devices authenticated under the same User account.
- **Clipboard_Entry**: A single unit of clipboard content (text, image, or file path) captured from the system clipboard.
- **Sync_Service**: The App component responsible for sending and receiving Clipboard_Entries to/from the backend.
- **Encryption_Service**: The App component responsible for end-to-end encrypting and decrypting Clipboard_Entries using keys derived from the User's credentials.
- **Auth_Service**: The App component responsible for managing User authentication via Firebase Authentication.
- **Firebase_Backend**: The combination of Firebase Authentication and Firebase Firestore used as the cloud backend.
- **E2E_Key**: A symmetric encryption key derived on-device from the User's credentials, never transmitted to the Firebase_Backend.
- **Clipboard_Monitor**: The platform-specific component that watches the system clipboard for changes.
- **Session**: An active authenticated connection between a Device and the Firebase_Backend.

---

## Requirements

### Requirement 1: User Account Management

**User Story:** As a User, I want to create and manage an account, so that my devices can be grouped together for clipboard syncing.

#### Acceptance Criteria

1. THE Auth_Service SHALL allow a User to register with an email address and password.
2. THE Auth_Service SHALL allow a User to sign in with a registered email address and password.
3. WHEN a User signs in successfully, THE Auth_Service SHALL establish a Session on the Device.
4. WHEN a User signs out, THE Auth_Service SHALL terminate the Session and stop all clipboard syncing on that Device.
5. IF registration fails due to an already-registered email, THEN THE Auth_Service SHALL return an error message indicating the email is already in use.
6. IF authentication fails due to invalid credentials, THEN THE Auth_Service SHALL return an error message and SHALL NOT establish a Session.
7. THE Auth_Service SHALL support password reset via a verification email sent to the User's registered address.

---

### Requirement 2: Clipboard Monitoring

**User Story:** As a User, I want the App to detect when I copy something, so that it can be synced to my other devices automatically.

#### Acceptance Criteria

1. THE App SHALL expose a single `ClipboardMonitor` abstraction that unifies platform-specific clipboard detection, so that all other App components interact with one interface regardless of the underlying platform.
2. WHERE the target platform is Android, Windows, Linux, or macOS, THE Clipboard_Monitor SHALL use the `clipshare_clipboard_listener` package (`^1.2.14`) via the `ClipboardListener` mixin and `onClipboardChanged` callback to receive native event-driven clipboard change notifications.
3. WHERE the target platform is iOS, THE Clipboard_Monitor SHALL use the `super_clipboard` package (latest) via `SystemClipboard.instance.read()` inside a `Timer.periodic` at 1-second intervals to detect clipboard changes, because Apple does not expose a native clipboard change event API to third-party apps.
4. WHEN a clipboard change event is received, THE Clipboard_Monitor SHALL capture the new content as a Clipboard_Entry.
5. THE Clipboard_Monitor SHALL capture clipboard content of type plain text.
6. THE Clipboard_Monitor SHALL capture clipboard content of type rich text (HTML).
7. THE Clipboard_Monitor SHALL capture clipboard content of type image (PNG or JPEG).
8. WHEN the system clipboard content is identical to the most recently captured Clipboard_Entry, THE Clipboard_Monitor SHALL NOT create a duplicate Clipboard_Entry.
9. IF the system clipboard content exceeds 5 MB in size, THEN THE Clipboard_Monitor SHALL discard the content and display a notification to the User indicating the size limit was exceeded.
10. WHEN the App writes a received Clipboard_Entry to the system clipboard, THE App SHALL use `super_clipboard`'s `SystemClipboard.instance.write()` across all platforms to support text, HTML, and PNG image content uniformly.
11. WHEN the App writes a received Clipboard_Entry to the system clipboard, THE Clipboard_Monitor SHALL suppress the resulting clipboard change event to prevent the write from being re-captured and re-synced.

---

### Requirement 3: End-to-End Encryption

**User Story:** As a User, I want my clipboard content to be encrypted before it leaves my device, so that no third party — including the server — can read it.

#### Acceptance Criteria

1. WHEN a User establishes a Session, THE Encryption_Service SHALL derive an E2E_Key deterministically from the User's account credentials using PBKDF2 with a minimum of 100,000 iterations and a SHA-256 hash.
2. THE Encryption_Service SHALL encrypt every Clipboard_Entry using AES-256-GCM before the Sync_Service transmits it to the Firebase_Backend.
3. THE Encryption_Service SHALL include a unique initialization vector (IV) with each encrypted Clipboard_Entry.
4. THE Encryption_Service SHALL decrypt a received Clipboard_Entry using the locally derived E2E_Key before writing it to the system clipboard.
5. THE E2E_Key SHALL never be transmitted to or stored on the Firebase_Backend.
6. IF decryption of a received Clipboard_Entry fails, THEN THE Encryption_Service SHALL discard the entry and log the failure locally without exposing raw ciphertext to the User.
7. FOR ALL valid Clipboard_Entries, encrypting then decrypting with the same E2E_Key SHALL produce a byte-for-byte identical result to the original content (round-trip property).

---

### Requirement 4: Real-Time Clipboard Sync

**User Story:** As a User, I want clipboard content copied on one device to appear on all my other devices instantly, so that I can paste it without manual transfer.

#### Acceptance Criteria

1. WHEN a new Clipboard_Entry is captured on a Device, THE Sync_Service SHALL encrypt and upload it to the Firebase_Backend within 2 seconds under normal network conditions.
2. WHEN a new Clipboard_Entry is written to the Firebase_Backend, THE Sync_Service on all other Devices in the same Device_Group SHALL receive and decrypt it within 3 seconds under normal network conditions.
3. WHEN a synced Clipboard_Entry is received and decrypted, THE App SHALL write the content to the system clipboard of the receiving Device.
4. THE Sync_Service SHALL use Firebase Firestore real-time listeners to receive new Clipboard_Entries without requiring manual refresh.
5. WHEN a Device receives a Clipboard_Entry that originated from itself, THE Sync_Service SHALL discard the entry and SHALL NOT overwrite the local system clipboard.
6. THE Sync_Service SHALL attach a Device identifier and UTC timestamp to each Clipboard_Entry before uploading.

---

### Requirement 5: Clipboard History

**User Story:** As a User, I want to view a history of recently synced clipboard items, so that I can access content I copied earlier.

#### Acceptance Criteria

1. THE App SHALL maintain a local history of the 50 most recent Clipboard_Entries received or sent during the current Session.
2. THE App SHALL display the clipboard history in reverse chronological order (most recent first).
3. WHEN a User selects a Clipboard_Entry from the history, THE App SHALL write that entry's content to the system clipboard.
4. WHEN a User deletes a Clipboard_Entry from the history, THE App SHALL remove it from the local history and SHALL delete the corresponding record from the Firebase_Backend.
5. THE App SHALL display a preview of each Clipboard_Entry in the history list, truncating text previews to 200 characters and showing a thumbnail for image entries.
6. WHEN the App is closed and reopened, THE App SHALL restore the clipboard history from the Firebase_Backend for the authenticated User.

---

### Requirement 6: Device Management

**User Story:** As a User, I want to see and manage which devices are syncing my clipboard, so that I can revoke access from devices I no longer use.

#### Acceptance Criteria

1. THE App SHALL display a list of all Devices currently or previously registered under the User's account.
2. THE App SHALL display the platform name, device name, and last-active timestamp for each Device in the list.
3. WHEN a User revokes a Device, THE App SHALL remove that Device from the Device_Group and SHALL prevent it from receiving future Clipboard_Entries.
4. WHEN a Device is revoked, THE Sync_Service on the revoked Device SHALL terminate its Session within 30 seconds of the revocation being written to the Firebase_Backend.
5. THE App SHALL register the current Device with the Firebase_Backend upon first successful sign-in, recording the platform, device name, and registration timestamp.

---

### Requirement 7: Offline Handling and Connectivity

**User Story:** As a User, I want the App to handle network interruptions gracefully, so that I don't lose clipboard content when connectivity is temporarily unavailable.

#### Acceptance Criteria

1. WHILE a Device has no network connectivity, THE Sync_Service SHALL queue captured Clipboard_Entries locally.
2. WHEN network connectivity is restored, THE Sync_Service SHALL upload all queued Clipboard_Entries to the Firebase_Backend in chronological order.
3. THE App SHALL display a visible indicator when the Sync_Service is operating in offline mode.
4. IF the local queue exceeds 20 pending Clipboard_Entries, THEN THE Sync_Service SHALL discard the oldest entries to maintain the queue at 20 entries and SHALL notify the User that older entries were dropped.

---

### Requirement 8: Background Operation and Minimal Resource Footprint

**User Story:** As a User, I want the App to run silently in the background with minimal resource usage, so that clipboard syncing happens automatically without impacting device performance or battery life.

#### Acceptance Criteria

1. WHERE the target platform is macOS, Windows, or Linux, THE App SHALL run as a system tray application with no main window required, presenting only a tray icon as its persistent UI presence.
2. WHERE the target platform is macOS, Windows, or Linux, THE App SHALL continue syncing clipboard content while the main window is closed, as long as the tray process remains running.
3. WHERE the target platform is Android, THE App SHALL run as a foreground service with a minimal persistent notification to satisfy Android background execution requirements.
4. WHERE the target platform is iOS, THE App SHALL perform clipboard monitoring and sync only while the App is in the foreground or within the background execution time granted by the iOS platform.
5. THE Clipboard_Monitor SHALL use event-driven clipboard change notifications on all platforms that support them, and SHALL NOT use busy-polling on those platforms, to avoid unnecessary CPU usage.
6. THE App SHALL not retain Clipboard_Entry content in memory beyond the duration of a single sync operation, releasing memory immediately after the entry has been encrypted and uploaded or written to the system clipboard.
7. THE App SHALL NOT acquire wake locks or prevent device sleep on any platform except where required by the platform's foreground service model.
8. WHEN the App is running in the background, THE App's CPU usage SHALL remain below 1% on average during periods with no clipboard activity.
