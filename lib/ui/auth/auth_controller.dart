import 'package:sint/sint.dart';

import '../../domain/interfaces/auth_service.dart';

class AuthController extends SintController implements AuthService {
  final RxnString _email = RxnString();
  final RxBool _busy = false.obs;

  @override
  bool get isAuthenticated => _email.value != null;

  @override
  bool get isBusy => _busy.value;

  @override
  String? get currentUserEmail => _email.value;

  @override
  Future<bool> signIn({required String email, required String password}) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty || password.isEmpty) return false;

    _busy.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 80));

    Sint.batch(() {
      _email.value = trimmed;
      _busy.value = false;
    });
    return true;
  }

  @override
  void signOut() {
    Sint.batch(() {
      _email.value = null;
      _busy.value = false;
    });
  }
}
