import 'package:sint/sint.dart';

import 'domain/interfaces/auth_service.dart';
import 'domain/interfaces/counter_service.dart';
import 'ui/auth/auth_controller.dart';
import 'ui/home/counter_controller.dart';

/// Application composition root following the Open Neom Clean Architecture standard.
///
/// Each feature exposes a pure domain contract (`*Service`) and a concrete
/// `SintController` implementation (`*Controller`). `Bind.putContract` and
/// `Bind.contract` register both types against a **single shared instance**
/// without bridge closures or duplicate widget wrappers.
class RootBinding extends Binding {
  static final List<Bind<dynamic>> _deps = <Bind<dynamic>>[
    // Eager permanent contract: session state lives for the full app lifecycle.
    Bind.putContract<AuthService, AuthController>(
      AuthController(),
      permanent: true,
    ),

    // Lazy contract: instantiated on first `Sint.find<CounterService>()` or
    // `Sint.find<CounterController>()`, recreated on demand (`fenix: true`).
    Bind.contract<CounterService, CounterController>(
      () => CounterController(),
      fenix: true,
    ),
  ];

  @override
  List<Bind<dynamic>> dependencies() => _deps;
}
