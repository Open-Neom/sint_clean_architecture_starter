import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sint/sint.dart';
import 'package:sint_clean_architecture_starter/domain/interfaces/auth_service.dart';
import 'package:sint_clean_architecture_starter/domain/interfaces/counter_service.dart';
import 'package:sint_clean_architecture_starter/main.dart';
import 'package:sint_clean_architecture_starter/ui/auth/auth_controller.dart';
import 'package:sint_clean_architecture_starter/ui/home/counter_controller.dart';

void main() {
  tearDown(() {
    CounterController.instancesCreated = 0;
    Sint.reset();
  });

  testWidgets(
    'RootBinding registers single-identity contracts and guards auth -> home flow',
    (tester) async {
      await tester.pumpWidget(const StarterApp());
      await tester.pumpAndSettle();

      // 1. AuthGuard redirected unauthenticated `/home` to `/login`.
      expect(find.byKey(const Key('sign_in_button')), findsOneWidget);

      // 2. Contract-First DI: AuthService and AuthController share 1 identity.
      final authByContract = Sint.find<AuthService>();
      final authByController = Sint.find<AuthController>();
      expect(identical(authByContract, authByController), isTrue);

      // 3. Lazy Contract-First DI: CounterController is NOT constructed on `/login`.
      expect(Sint.isPrepared<CounterService>(), isTrue);
      expect(CounterController.instancesCreated, 0);

      // 4. Sign in -> navigates to `/home` and constructs CounterController ONCE.
      await tester.tap(find.byKey(const Key('sign_in_button')));
      await tester.pumpAndSettle();

      expect(
        identical(Sint.find<CounterService>(), Sint.find<CounterController>()),
        isTrue,
      );
      expect(CounterController.instancesCreated, 1);
      expect(
        find.text('Reactive Signal Count: 0 (×2 = 0)'),
        findsOneWidget,
      );

      // 5. Signal increment updates Obx + Sint.computed (`doubled`).
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      expect(
        find.text('Reactive Signal Count: 1 (×2 = 2)'),
        findsOneWidget,
      );

      // 6. Instant O(1) locale switch (`en_US` -> `es_ES`).
      await tester.tap(find.byKey(const Key('toggle_locale_button')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(
        find.text('Señal Reactiva: 1 (×2 = 2)'),
        findsOneWidget,
      );
    },
  );
}
