import '../../models/clipboard_models.dart';

abstract class ClipboardMonitor {
  Stream<ClipboardEntry> get onClipboardChanged;
  Future<void> writeToClipboard(ClipboardEntry entry);
  void suppressNextChange();
  void dispose();
}
