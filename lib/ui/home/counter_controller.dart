import 'package:sint/sint.dart';

import '../../domain/interfaces/counter_service.dart';

class CounterController extends SintController implements CounterService {
  CounterController() {
    instancesCreated++;
  }

  /// Tracks lazy instantiations in tests to verify single-identity Contract-First DI.
  static int instancesCreated = 0;

  final RxInt _count = 0.obs;
  late final Computed<int> _doubled = Sint.computed(() => _count.value * 2);

  @override
  int get count => _count.value;

  @override
  int get doubled => _doubled.value;

  @override
  void increment() => _count.value++;

  @override
  void reset() => _count.value = 0;
}
