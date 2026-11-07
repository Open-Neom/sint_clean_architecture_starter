/// Pure domain contract for authentication.
///
/// Feature screens and sibling modules depend ONLY on [AuthService],
/// never on the concrete `AuthController` implementation.
abstract class AuthService {
  bool get isAuthenticated;
  bool get isBusy;
  String? get currentUserEmail;

  Future<bool> signIn({required String email, required String password});
  void signOut();
}
