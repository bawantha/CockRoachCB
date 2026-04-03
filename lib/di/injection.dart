import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/interfaces/auth_service.dart';
import '../services/interfaces/clipboard_monitor.dart';
import '../services/interfaces/encryption_service.dart';
import '../services/interfaces/sync_service.dart';
import '../services/interfaces/history_service.dart';
import '../services/interfaces/device_manager.dart';
import '../services/implementations/firebase_auth_service.dart';
import '../services/implementations/app_encryption_service.dart';
import '../services/implementations/firestore_sync_service.dart';
import '../services/implementations/app_history_service.dart';
import '../services/implementations/platform_clipboard_monitor.dart';
import '../services/implementations/app_device_manager.dart';
import '../orchestrator/app_orchestrator.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<EncryptionService>(() => AppEncryptionService());
  
  getIt.registerLazySingleton<SyncService>(
    () => FirestoreSyncService(getIt<AuthService>())
  );
  getIt.registerLazySingleton<HistoryService>(
    () => AppHistoryService(getIt<SharedPreferences>(), getIt<AuthService>())
  );
  getIt.registerLazySingleton<DeviceManager>(
    () => AppDeviceManager(getIt<AuthService>())
  );
  getIt.registerLazySingleton<ClipboardMonitor>(
    () => PlatformClipboardMonitor()
  );

  getIt.registerSingleton<AppOrchestrator>(
    AppOrchestrator(
      getIt<AuthService>(),
      getIt<ClipboardMonitor>(),
      getIt<EncryptionService>(),
      getIt<SyncService>(),
      getIt<DeviceManager>(),
    )
  );
}
