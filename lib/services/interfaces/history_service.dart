import '../../models/clipboard_models.dart';

abstract class HistoryService {
  List<ClipboardEntryMeta> get history;
  Future<ClipboardEntry> fetchFullContent(String entryId);
  Future<void> addEntry(ClipboardEntryMeta meta);
  Future<void> deleteEntry(String entryId);
  Future<void> restoreFromRemote();
}
