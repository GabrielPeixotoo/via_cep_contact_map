import '../../shared/shared.dart';
import 'home.dart';

class HomeModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<HomeController>(
      HomeController.new,
    );
  }
}
