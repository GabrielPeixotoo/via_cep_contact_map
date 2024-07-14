import '../../shared/shared.dart';
import 'presentation/pages/pages.dart';

class LoginModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<SaveCurrentUserUsecase>(
      () => LocalSaveCurrentUser(localStorage: instance()),
    );
    instance.registerFactory<LoginUsecase>(
      () => LocalLogin(fetchUsersUsecase: instance(), saveCurrentUserUsecase: instance()),
    );
    instance.registerFactory<LoginController>(() => LoginController(
          appNavigator: instance(),
          uiHelper: instance(),
          loginUsecase: instance(),
        ));
    instance.registerFactory<SignUpController>(
      () => SignUpController(
        appNavigator: instance(),
        uiHelper: instance(),
        signUpUsecase: instance(),
      ),
    );
  }
}
