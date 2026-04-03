import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import 'styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'test@example.com');
  final _passwordController = TextEditingController(text: 'password123'); // Default for quick testing
  bool _isLoading = false;
  bool _isLogin = true; // Toggle between login and register

  void _submit() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) return;
    if (_isLogin) {
      context.read<AuthBloc>().add(LoginRequested(_emailController.text, _passwordController.text));
    } else {
      context.read<AuthBloc>().add(RegisterRequested(_emailController.text, _passwordController.text));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.error,
            ));
          }
        },
        builder: (context, state) {
          _isLoading = state is AuthLoading;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.sync_alt, size: 80, color: AppTheme.primary),
                    const SizedBox(height: 24),
                    const Text(
                      'Universal Sync',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'End-to-End Encrypted Clipboard',
                      style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: AppTheme.textSecondary),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Encryption Password',
                        prefixIcon: Icon(Icons.lock, color: AppTheme.textSecondary),
                      ),
                      obscureText: true,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      child: _isLoading 
                        ? const SizedBox(
                            width: 24, height: 24, 
                            child: CircularProgressIndicator(color: AppTheme.textPrimary, strokeWidth: 2)
                          )
                        : Text(_isLogin ? 'Connect & Sync (Sign In)' : 'Create Account & Sync', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _isLoading ? null : () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? 'Need an account? Register instead' : 'Already have an account? Sign In',
                        style: const TextStyle(color: AppTheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
