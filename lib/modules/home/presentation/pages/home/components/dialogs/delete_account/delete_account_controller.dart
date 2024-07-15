import '../../../../../../../../shared/shared.dart';
import '../../../../../../domain/domain.dart';
import '../../../home.dart';

class DeleteAccountController extends FormNotifier<DeleteAccountState> {
  final UIHelper uiHelper;
  final AppNavigator appNavigator;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;
  final DeleteCurrentUserUsecase deleteCurrentUserUsecase;
  final DeleteUserUsecase deleteUserUsecase;
  final DeleteAllContactsUsecase deleteAllContactsUsecase;

  DeleteAccountController({
    required this.uiHelper,
    required this.appNavigator,
    required this.fetchCurrentUserUsecase,
    required this.deleteCurrentUserUsecase,
    required this.deleteUserUsecase,
    required this.deleteAllContactsUsecase,
  }) : super(DeleteAccountState.initial());

  final passwordTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);

  @override
  List<CustomTextEditingController> get fieldControllers => [
        passwordTextController,
      ];

  @override
  void onFormChanged() {
    if (isFormValid) {
      value = DeleteAccountState.validated();
    } else {
      value = DeleteAccountState.initial();
    }
  }

  Future<void> deleteAccountAndData() async {
    try {
      value = DeleteAccountState.loading();
      await deleteUserUsecase(password: passwordTextController.text);
      await deleteAllContactsUsecase();
      await deleteCurrentUserUsecase();

      value = DeleteAccountState.validated();
      appNavigator.pushAndClearStack(AppRoutes.loginPage);
    } on ConnectionError {
      value = DeleteAccountState.validated();
    } catch (error) {
      if (error is WrongPassword) {
        passwordTextController.errorText.value = 'Senha errada.';
        value = DeleteAccountState.validated();
      } else {
        value = DeleteAccountState.validated();
      }
    }
  }

  Future<void> goToSignUpPage() async {
    appNavigator.pushReplacement(AppRoutes.signUpPage);
  }
}
