class CoreUrl {
  final String name;
  final String path;

  const CoreUrl({
    required this.name,
    required this.path,
  });
}

abstract class CoreUrls {
  static const CoreUrl home = CoreUrl(name: 'Home', path: '/');
}
