import 'dart:async';

class TimedDelay {
  /// Fausse attente pour simuler la personnalisation
  Future<void> simulateDelay() async {
    _refreshTimer?.cancel();
    final completer = Completer<void>();
    _refreshTimer = Timer(const Duration(seconds: 3), completer.complete);
    await completer.future;
  }

  Timer? _refreshTimer;
}
