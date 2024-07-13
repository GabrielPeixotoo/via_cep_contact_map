import '../../../../../../shared/shared.dart';
import '../sign_up.dart';

class SignUpController extends FormNotifier<SignUpState> {
  final AppNavigator appNavigator;
  final SignUpUsecase signUpUsecase;
  @override
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

  void goToLoginPage() {}

  void validateField() {
    if (emailTextField.text.isNotEmpty && passwordTextField.text.isNotEmpty) {
      emailTextField.errorText.value = null;
      passwordTextField.errorText.value = null;
      value = SignUpState.validated();
    } else {
      value = SignUpState.initial();
    }
  }

  Future<void> register() async {
    try {
      value = SignUpState.loading();
      // const user = AuthEntity(token: '');
      // await saveAuthUsecase(authEntity: user);
      appNavigator.pushReplacement(AppRoutes.homePage);
      value = SignUpState.validated();
    } on ConnectionError {
      value = SignUpState.validated();
    } catch (error) {
      if (error is UserAlreadyExists) {
        emailTextField.errorText.value = '';
        passwordTextField.errorText.value = 'Usuário já existe';
      } else {
        value = SignUpState.validated();
      }
    }
  }
}
