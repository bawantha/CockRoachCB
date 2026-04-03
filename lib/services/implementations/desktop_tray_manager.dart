import 'dart:io' show Platform, exit;
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';
import '../interfaces/tray_manager.dart' as app;

class DesktopTrayManager implements app.TrayManager, TrayListener {
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    if (!Platform.isMacOS && !Platform.isWindows && !Platform.isLinux) return;
    
    await windowManager.ensureInitialized();
    await trayManager.setIcon(
      Platform.isWindows ? 'assets/icon.ico' : 'assets/icon.png',
    );
    
    List<MenuItem> items = [
      MenuItem(
        key: 'show_app',
        label: 'Show Dashboard',
      ),
      MenuItem.separator(),
      MenuItem(
        key: 'exit_app',
        label: 'Quit Universal Sync',
      ),
    ];
    
    await trayManager.setContextMenu(Menu(items: items));
    trayManager.addListener(this);
    _isInitialized = true;
  }

  @override
  void updateSyncStatus(String status) {
    if (!_isInitialized) return;
    trayManager.setToolTip('Universal Sync: $status');
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    trayManager.destroy();
  }

  Future<void> showWindow() async {
    if (!_isInitialized) return;
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> hideWindow() async {
    if (!_isInitialized) return;
    await windowManager.hide();
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayIconRightMouseUp() {}

  @override
  void onTrayIconMouseUp() {}

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'show_app') {
      showWindow();
    } else if (menuItem.key == 'exit_app') {
      exit(0);
    }
  }
}
