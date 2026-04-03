import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/app_logger.dart';
import '../interfaces/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((User? user) => user?.uid);
  }

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<void> register(String email, String password) async {
    try {
      appLogger.i('Registering new user with email: $email');
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      appLogger.i('Successfully registered user: $email');
    } catch (e, st) {
      appLogger.e('Failed to register user', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      appLogger.i('Attempting sign in for email: $email');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      appLogger.i('Successfully signed in user: $email');
    } catch (e, st) {
      appLogger.e('Failed to sign in', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    appLogger.i('Signing out user');
    try {
      await _firebaseAuth.signOut();
      appLogger.i('Successfully signed out');
    } catch (e, st) {
      appLogger.e('Error during sign out', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    appLogger.i('Sending password reset email to: $email');
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      appLogger.i('Successfully sent password reset email');
    } catch (e, st) {
      appLogger.e('Failed to send password reset email', error: e, stackTrace: st);
      rethrow;
    }
  }
}
