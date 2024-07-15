import 'package:flutter/material.dart';

import '../../../../../../shared/shared.dart';
import '../sign_up.dart';

class SignUpController extends FormNotifier<SignUpState> {
  final AppNavigator appNavigator;
  final SignUpUsecase signUpUsecase;
  final UIHelper uiHelper;

  SignUpController({
    required this.appNavigator,
    required this.signUpUsecase,
    required this.uiHelper,
  }) : super(SignUpState.initial());

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
      value = SignUpState.validated();
    } else {
      value = SignUpState.initial();
    }
  }

  void goToLoginPage() {
    appNavigator.pushReplacement(AppRoutes.loginPage);
  }

  Future<void> register() async {
    try {
      value = SignUpState.loading();
      await signUpUsecase(params: SignUpUsecaseParams(email: emailTextField.text, password: passwordTextField.text));
      value = SignUpState.validated();
      appNavigator.pushReplacement(AppRoutes.loginPage);
      uiHelper.showCustomSnackBar(
          snackBar:
              makeSnackBar(icon: Icons.check, text: 'Cadastro realizado com sucesso!', backgroundColor: Colors.green));
    } on ConnectionError {
      value = SignUpState.validated();
    } catch (error) {
      if (error is UserAlreadyExists) {
        uiHelper.showCustomSnackBar(
            snackBar: makeSnackBar(icon: Icons.error, text: 'Usuário já existe!', backgroundColor: Colors.red));
        value = SignUpState.validated();
      } else {
        value = SignUpState.validated();
      }
    }
  }
}
