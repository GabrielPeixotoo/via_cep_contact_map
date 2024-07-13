import '../../../../../../shared/shared.dart';

class SplashController {
  final AppNavigator appNavigator;
  SplashController({
    required this.appNavigator,
  });
  Future<void> goToHome() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    appNavigator.pushReplacement(AppRoutes.loginPage);
  }
}
