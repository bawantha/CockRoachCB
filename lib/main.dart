import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'di/injection.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/history_bloc.dart';
import 'blocs/device_bloc.dart';
import 'firebase_options.dart';

import 'ui/styles.dart';
import 'ui/login_screen.dart';
import 'ui/dashboard_screen.dart';
import 'ui/device_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/devices',
      builder: (context, state) => const DeviceScreen(),
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;
    final isGoingToLogin = state.matchedLocation == '/login';
    
    if (authState is Unauthenticated && !isGoingToLogin) {
      return '/login';
    }
    if (authState is Authenticated && isGoingToLogin) {
      return '/';
    }
    return null;
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt(), getIt())..add(CheckAuthStatus()),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(getIt())..add(LoadHistory()),
        ),
        BlocProvider<DeviceBloc>(
          create: (context) => DeviceBloc(getIt())..add(LoadDevices()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Universal Clipboard Sync',
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}
