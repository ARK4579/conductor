import 'package:conductor/conductor.dart';

abstract class RemoteDBC {
  Future<void> remoteSync();
}
