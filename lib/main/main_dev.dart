import '../shared/shared.dart';
import 'main.dart';

void main() async {
  InjectionContainer.instance.registerLazySingleton(() => FlavorConfig.dev);

  run();
}
