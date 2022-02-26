import 'dart:async';

import 'package:flutter_hooks/flutter_hooks.dart';

typedef PeriodicTimerCallback = void Function(Timer);
void usePeriodicTimer({
  required Duration duration,
  required PeriodicTimerCallback callback,
  List<Object?> keys = const [],
}) {
  useEffect(() {
    final timer = Timer.periodic(duration, callback);
    return () => timer.cancel();
  }, [...keys, duration, callback]);
}
