import 'dart:ui';

import 'package:sint/sint.dart';

class AppTranslations extends Translations {
  static final Rx<Locale> currentLocale = const Locale('en', 'US').obs;

  static void toggleLocale() {
    final next = currentLocale.value.languageCode == 'es'
        ? const Locale('en', 'US')
        : const Locale('es', 'ES');
    Sint.locale = next;
    currentLocale.value = next;
  }

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_title': 'SINT Clean Architecture Starter',
      'login_title': 'Sign in to Open Neom Starter',
      'login_subtitle': 'Powered by SINT 2.1 Contract-First DI & O(1) Signals',
      'email_label': 'Email',
      'password_label': 'Password',
      'sign_in': 'Sign In',
      'sign_out': 'Sign Out',
      'welcome_user': 'Welcome, @email',
      'counter_label': 'Reactive Signal Count: @count (×2 = @doubled)',
      'increment': 'Increment',
      'reset': 'Reset',
      'switch_lang': 'Español',
    },
    'es_ES': {
      'app_title': 'Plantilla Clean Architecture con SINT',
      'login_title': 'Inicia sesión en Open Neom Starter',
      'login_subtitle': 'Impulsado por SINT 2.1 Contract-First DI y Señales O(1)',
      'email_label': 'Correo electrónico',
      'password_label': 'Contraseña',
      'sign_in': 'Entrar',
      'sign_out': 'Cerrar sesión',
      'welcome_user': 'Bienvenido, @email',
      'counter_label': 'Señal Reactiva: @count (×2 = @doubled)',
      'increment': 'Incrementar',
      'reset': 'Reiniciar',
      'switch_lang': 'English',
    },
  };
}
