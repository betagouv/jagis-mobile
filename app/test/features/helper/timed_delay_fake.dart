import 'package:app/core/infrastructure/timed_delay.dart';

class TimedDelayFake implements TimedDelay {
  const TimedDelayFake();

  @override
  Future<void> simulateDelay() async {}
}
