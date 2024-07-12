import '../shared.dart';

enum FlavorConfig {
  dev(envFile: 'dev.env', showInspector: true),
  homolog(envFile: 'prod.env', showInspector: true),
  prod(envFile: 'prod.env', showInspector: false);

  final String envFile;
  final bool showInspector;

  const FlavorConfig({required this.envFile, required this.showInspector});

  static FlavorConfig get instance =>
      InjectionContainer.instance.get<FlavorConfig>();

  static bool get isDev => instance == dev;
  static bool get isHomolog => instance == homolog;
  static bool get isProd => instance == prod;
}
