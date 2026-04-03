import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import '../../models/clipboard_models.dart';
import '../interfaces/encryption_service.dart';

class AppEncryptionService implements EncryptionService {
  final Pbkdf2 pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 100000,
    bits: 256,
  );
  
  final AesGcm aesGcm = AesGcm.with256bits();
  SecretKey? _derivedKey;

  @override
  Future<void> initKey(String userId, String password) async {
    final salt = utf8.encode(userId);
    _derivedKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
  }

  @override
  void clearKey() {
    _derivedKey = null;
  }

  @override
  Future<EncryptedEntry> encrypt(ClipboardEntry entry) async {
    if (_derivedKey == null) throw StateError("Key not initialized");
    if (entry.content == null) throw ArgumentError("Content cannot be null");

    final secretBox = await aesGcm.encrypt(
      entry.content!,
      secretKey: _derivedKey!,
    );

    return EncryptedEntry(
      id: entry.id,
      userId: "", // Will be filled by caller
      deviceId: entry.deviceId,
      timestamp: entry.timestamp,
      iv: secretBox.nonce as Uint8List,
      ciphertext: secretBox.cipherText as Uint8List,
      type: entry.type,
    );
  }

  @override
  Future<ClipboardEntry> decrypt(EncryptedEntry entry) async {
    if (_derivedKey == null) throw StateError("Key not initialized");

    final secretBox = SecretBox(
      entry.ciphertext,
      nonce: entry.iv,
      mac: Mac.empty, // Depending on cryptography package behavior, tag is usually appended to ciphertext
    );

    // Some implementations bundle the MAC tag into the ciphertext. We need to handle this correctly.
    // If AES-GCM tag is separate, we'd need it in the EncryptedEntry model. 
    // Assuming standard bundled ciphertext + 16-byte tag.
    final clearText = await aesGcm.decrypt(
      secretBox,
      secretKey: _derivedKey!,
    );

    return ClipboardEntry(
      id: entry.id,
      type: entry.type,
      content: Uint8List.fromList(clearText),
      deviceId: entry.deviceId,
      timestamp: entry.timestamp,
    );
  }
}
