import '../services/interfaces/auth_service.dart';
import '../services/interfaces/clipboard_monitor.dart';
import '../services/interfaces/encryption_service.dart';
import '../services/interfaces/sync_service.dart';
import '../services/interfaces/device_manager.dart';
import '../utils/app_logger.dart';
import 'dart:async';

class AppOrchestrator {
  final AuthService _authService;
  final ClipboardMonitor _clipboardMonitor;
  final EncryptionService _encryptionService;
  final SyncService _syncService;
  final DeviceManager _deviceManager;
  
  StreamSubscription? _authSub;
  StreamSubscription? _clipSub;
  StreamSubscription? _syncSub;

  AppOrchestrator(
    this._authService,
    this._clipboardMonitor,
    this._encryptionService,
    this._syncService,
    this._deviceManager,
  ) {
    _authSub = _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(String? userId) async {
    if (userId != null) {
      // User logged in
      appLogger.i('User logged in: $userId, initializing orchestration...');
      await _deviceManager.registerDevice();
      
      _clipSub = _clipboardMonitor.onClipboardChanged.listen((entry) async {
         appLogger.d('Clipboard changed locally. Encrypting and uploading...');
         final filledEntry = entry.copyWith(deviceId: _deviceManager.currentDeviceId);
         try {
           final encrypted = await _encryptionService.encrypt(filledEntry);
           await _syncService.upload(encrypted);
           appLogger.i('Successfully synced clipboard entry to cloud.');
         } catch (e, stackTrace) {
           appLogger.e('Failed to encrypt/upload clipboard entry', error: e, stackTrace: stackTrace);
         }
      });

      _syncSub = _syncService.incomingEntries.listen((encrypted) async {
         if (encrypted.deviceId == _deviceManager.currentDeviceId) return;
         
         appLogger.d('Incoming remote clipboard entry detected.');
         try {
           final entry = await _encryptionService.decrypt(encrypted);
           await _clipboardMonitor.writeToClipboard(entry);
           appLogger.i('Successfully decrypted and wrote incoming entry to clipboard.');
         } catch (e, stackTrace) {
           appLogger.e('Failed to decrypt/write incoming incoming entry', error: e, stackTrace: stackTrace);
         }
      });
      
    } else {
      // User logged out
      appLogger.w('User logged out, clearing orchestration subscriptions.');
      _clipSub?.cancel();
      _syncSub?.cancel();
      _encryptionService.clearKey();
    }
  }

  void dispose() {
    _authSub?.cancel();
    _clipSub?.cancel();
    _syncSub?.cancel();
    _clipboardMonitor.dispose();
    _syncService.dispose();
  }
}
