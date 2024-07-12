import '../../shared/shared.dart';
import 'presentation/pages/sign_up/sign_up.dart';

class LoginModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<SignUpController>(
      () => SignUpController(
        appNavigator: instance(),
        saveAuthUsecase: instance(),
        uiHelper: instance(),
      ),
    );
  }
}
