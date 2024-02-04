import 'package:conductor/conductor.dart';

// once we introduce multi-business configuration we will have to update this logic
// in that case, before sign-in we will use default database to get names of known businesses
// or other business independent, system based settings
final businessDbNameProvider =
    StateProvider<String?>((ref) => CoreValues.defaultBusinessDbName);
