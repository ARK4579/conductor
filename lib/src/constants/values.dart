abstract class CoreValues {
  static String get systemDbName => "system";
  static String get defaultBusinessDbName => "default";

  static List<String> get protectedDBNames => [
        systemDbName,
      ];
}
