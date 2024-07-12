import '../../shared/shared.dart';
import 'splash.dart';

class SplashModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<SplashController>(
      () => SplashController(appNavigator: instance()),
    );
  }
}
