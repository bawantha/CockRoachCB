import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/clipboard_models.dart';
import '../interfaces/device_manager.dart';
import '../interfaces/auth_service.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AppDeviceManager implements DeviceManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService;
  
  // A naive deviceId generation for the sake of example.
  // In production, use platform-specific unique IDs or generated UUID kept in secure storage.
  String? _deviceId;
  
  AppDeviceManager(this._authService);

  @override
  String get currentDeviceId => _deviceId ?? "unknown-device";

  @override
  Future<void> registerDevice() async {
    final userId = _authService.currentUserId;
    if (userId == null) return;
    
    // Generate/fetch a local device ID. Here we'll hardcode a dummy or parse Platform Info.
    final deviceInfo = DeviceInfoPlugin();
    String deviceName = "Unknown Device";
    
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      deviceName = "\${info.manufacturer} \${info.model}";
      _deviceId = "android-\${info.id}";
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      deviceName = info.computerName;
      _deviceId = "macos-\${info.systemGUID}";
    } else {
      _deviceId = "generic-\${DateTime.now().millisecondsSinceEpoch}";
    }

    final info = DeviceInfo(
      deviceId: _deviceId!,
      platform: Platform.operatingSystem,
      deviceName: deviceName,
      registeredAt: DateTime.now(),
      lastActiveAt: DateTime.now(),
      isRevoked: false,
    );

    await _firestore
      .collection('users')
      .doc(userId)
      .collection('devices')
      .doc(_deviceId)
      .set(info.toJson());
  }

  @override
  Stream<List<DeviceInfo>> get devices {
    final userId = _authService.currentUserId;
    if (userId == null) return Stream.value([]);
    
    return _firestore
      .collection('users')
      .doc(userId)
      .collection('devices')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((d) => DeviceInfo.fromJson(d.data())).toList();
      });
  }

  @override
  Future<void> revokeDevice(String deviceId) async {
    final userId = _authService.currentUserId;
    if (userId == null) return;
    
    await _firestore
      .collection('users')
      .doc(userId)
      .collection('devices')
      .doc(deviceId)
      .update({'isRevoked': true});
  }
}
