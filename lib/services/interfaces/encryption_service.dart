import '../../models/clipboard_models.dart';

abstract class EncryptionService {
  Future<void> initKey(String userId, String password);
  Future<EncryptedEntry> encrypt(ClipboardEntry entry);
  Future<ClipboardEntry> decrypt(EncryptedEntry entry);
  void clearKey();
}
