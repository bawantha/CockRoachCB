import '../../models/clipboard_models.dart';

abstract class DeviceManager {
  Future<void> registerDevice();
  Stream<List<DeviceInfo>> get devices;
  Future<void> revokeDevice(String deviceId);
  String get currentDeviceId;
}
