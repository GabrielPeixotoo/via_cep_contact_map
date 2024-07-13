import 'package:flutter/material.dart';

import '../../../../../../shared/shared.dart';
import '../../pages.dart';

class LoginController extends FormNotifier<LoginState> {
  final LoginUsecase loginUsecase;
  final UIHelper uiHelper;
  final AppNavigator appNavigator;
  LoginController({
    required this.loginUsecase,
    required this.uiHelper,
    required this.appNavigator,
  }) : super(LoginState.initial());

  final emailTextField = CustomTextEditingController(validator: ValidatorBuilder().build().call);
  final passwordTextField = CustomTextEditingController(validator: ValidatorBuilder().build().call);

  @override
  List<CustomTextEditingController> get fieldControllers => [
        emailTextField,
        passwordTextField,
      ];

  @override
  void onFormChanged() {
    if (isFormValid) {
      value = LoginState.validated();
    } else {
      value = LoginState.initial();
    }
  }

  void goToLoginPage() {}

  void validateField() {
    if (emailTextField.text.isNotEmpty && passwordTextField.text.isNotEmpty) {
      emailTextField.errorText.value = null;
      passwordTextField.errorText.value = null;
      value = LoginState.validated();
    } else {
      value = LoginState.initial();
    }
  }

  Future<void> login() async {
    try {
      value = LoginState.loading();
      await loginUsecase(authEntity: AuthEntity(email: emailTextField.text, password: passwordTextField.text));

      value = LoginState.validated();
    } on ConnectionError {
      value = LoginState.validated();
    } catch (error) {
      if (error is UserNotFound) {
        uiHelper.showCustomSnackBar(
            snackBar: makeSnackBar(icon: Icons.error, text: 'Usuário não encontrado!', backgroundColor: Colors.red));
        value = LoginState.validated();
      } else {
        value = LoginState.validated();
      }
    }
  }

  Future<void> goToSignUpPage() async {
    appNavigator.pushReplacement(AppRoutes.signUpPage);
  }
}
