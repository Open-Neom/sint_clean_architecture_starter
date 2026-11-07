/// Pure domain contract for counter state & derived metrics.
abstract class CounterService {
  int get count;
  int get doubled;

  void increment();
  void reset();
}
