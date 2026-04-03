import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'di/injection.dart';
import 'blocs/auth_bloc.dart';
import 'blocs/history_bloc.dart';
import 'blocs/device_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        routerConfig: _router,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(const LoginRequested('test@example.com', 'password'));
          },
          child: const Text('Mock Login'),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          )
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
             return ListView.builder(
               itemCount: state.entries.length,
               itemBuilder: (context, index) {
                 final entry = state.entries[index];
                 return ListTile(title: Text(entry.preview));
               }
             );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
