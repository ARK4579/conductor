import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerModel {
  final DateTime currentTime;

  const TimerModel(this.currentTime);
}

final currentTimerProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(
      const Duration(milliseconds: 500), (_) => DateTime.now());
});
