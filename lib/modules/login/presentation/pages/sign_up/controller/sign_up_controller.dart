import '../../../../../../shared/shared.dart';
import '../sign_up.dart';

class SignUpController extends FormNotifier<SignUpState> {
  final AppNavigator appNavigator;
  final SaveAuthUsecase saveAuthUsecase;
  @override
  final UIHelper uiHelper;

  SignUpController({
    required this.appNavigator,
    required this.saveAuthUsecase,
    required this.uiHelper,
  }) : super(SignUpState.initial());

  final userNameTextField = CustomTextEditingController(validator: ValidatorBuilder().build().call);
  final passwordTextField = CustomTextEditingController(validator: ValidatorBuilder().build().call);

  @override
  List<CustomTextEditingController> get fieldControllers => [
        userNameTextField,
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
    if (userNameTextField.text.isNotEmpty && passwordTextField.text.isNotEmpty) {
      userNameTextField.errorText.value = null;
      passwordTextField.errorText.value = null;
      value = SignUpState.validated();
    } else {
      value = SignUpState.initial();
    }
  }

  Future<void> register() async {
    try {
      value = SignUpState.loading();
      const user = AuthEntity(token: '');
      await saveAuthUsecase(authEntity: user);
      appNavigator.pushReplacement(AppRoutes.homePage);
      value = SignUpState.validated();
    } on ConnectionError {
      value = SignUpState.validated();
    } catch (error) {
      if (error is NotFoundError) {
        userNameTextField.errorText.value = '';
        passwordTextField.errorText.value = 'Usuário não encontrado';
      } else {
        value = SignUpState.validated();
      }
    }
  }
}
