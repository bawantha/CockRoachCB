abstract class TrayManager {
  Future<void> init();
  void updateSyncStatus(String status);
  void dispose();
}
