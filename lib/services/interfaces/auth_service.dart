abstract class AuthService {
  Stream<String?> get authStateChanges;
  Future<void> register(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
  String? get currentUserId;
}
