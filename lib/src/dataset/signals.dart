import 'package:conductor/conductor.dart';

abstract class Signal {
  String get name;

  int? at;

  @override
  String toString() {
    return '--$name';
  }

  void set() => Dataset().setSignal(this);
}

class CurrentDateTimeQuaterRangeSignal extends Signal {
  @override
  String get name => 'currentDateTimeQuaterRange';
}

class CurrentDateTimeSignal extends Signal {
  @override
  String get name => 'currentDateTime';
}
