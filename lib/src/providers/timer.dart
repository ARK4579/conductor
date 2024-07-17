import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentTimerProvider = StreamProvider<DateTime>((ref) {
  return Stream.periodic(const Duration(milliseconds: 10), (_) => DateTime.now());
});
