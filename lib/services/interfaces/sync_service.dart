import '../../models/clipboard_models.dart';

abstract class SyncService {
  Future<void> upload(EncryptedEntry entry);
  Stream<EncryptedEntry> get incomingEntries;
  Future<void> deleteEntry(String entryId);
  void dispose();
}
