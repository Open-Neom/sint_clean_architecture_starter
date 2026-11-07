import 'package:flutter/material.dart';
import 'package:sint/sint.dart';

import 'app_routes.dart';
import 'data/translations/app_translations.dart';
import 'root_binding.dart';

void main() {
  runApp(const StarterApp());
}

class StarterApp extends StatelessWidget {
  const StarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SintMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SINT Clean Architecture Starter',
      binds: RootBinding().dependencies(),
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoutes.home,
      sintPages: AppRoutes.pages,
      globalMiddlewares: [AuthGuard()],
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
    );
  }
}
