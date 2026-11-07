import 'package:flutter/material.dart';
import 'package:sint/sint.dart';

import '../../app_routes.dart';
import '../../data/translations/app_translations.dart';
import '../../domain/interfaces/auth_service.dart';
import '../../domain/interfaces/counter_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Both features resolved strictly by domain contract — zero coupling to controllers.
    final auth = Sint.find<AuthService>();
    final counter = Sint.find<CounterService>();

    return Obx(() {
      AppTranslations.currentLocale.value;
      return Scaffold(
        appBar: AppBar(
          title: Text('app_title'.tr),
          actions: [
            TextButton(
              key: const Key('toggle_locale_button'),
              onPressed: AppTranslations.toggleLocale,
              child: Text('switch_lang'.tr),
            ),
            IconButton(
              key: const Key('sign_out_button'),
              tooltip: 'sign_out'.tr,
              icon: const Icon(Icons.logout),
              onPressed: () {
                auth.signOut();
                Sint.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'welcome_user'.trParams({
                    'email': auth.currentUserEmail ?? '',
                  }),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'counter_label'.trParams({
                    'count': '${counter.count}',
                    'doubled': '${counter.doubled}',
                  }),
                  key: const Key('counter_text'),
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  children: [
                    FilledButton.icon(
                      key: const Key('increment_button'),
                      onPressed: counter.increment,
                      icon: const Icon(Icons.add),
                      label: Text('increment'.tr),
                    ),
                    OutlinedButton.icon(
                      key: const Key('reset_button'),
                      onPressed: counter.reset,
                      icon: const Icon(Icons.refresh),
                      label: Text('reset'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
