import 'package:flutter/material.dart';
import 'package:sint/sint.dart';

import '../../app_routes.dart';
import '../../data/translations/app_translations.dart';
import '../../domain/interfaces/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl =
      TextEditingController(text: 'architect@openneom.dev');
  final TextEditingController _passwordCtrl =
      TextEditingController(text: 'sint210');

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthService auth) async {
    final ok = await auth.signIn(
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    );
    if (ok) {
      Sint.offAllNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // UI depends strictly on the abstract AuthService contract.
    final auth = Sint.find<AuthService>();

    return Obx(() {
      AppTranslations.currentLocale.value;
      return Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          actions: [
            TextButton(
              onPressed: AppTranslations.toggleLocale,
              child: Text('switch_lang'.tr),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'login_title'.tr,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('login_subtitle'.tr),
                  const SizedBox(height: 24),
                  TextField(
                    key: const Key('email_field'),
                    controller: _emailCtrl,
                    decoration: InputDecoration(labelText: 'email_label'.tr),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const Key('password_field'),
                    controller: _passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'password_label'.tr),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    key: const Key('sign_in_button'),
                    onPressed: auth.isBusy ? null : () => _submit(auth),
                    child: auth.isBusy
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('sign_in'.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
