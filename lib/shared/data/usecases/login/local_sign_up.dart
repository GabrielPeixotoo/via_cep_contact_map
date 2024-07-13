import '../../../shared.dart';

class LocalSignUp implements SignUpUsecase {
  final FetchUserUsecase fetchAuthUsecase;
  final SaveUserUsecase saveAuthUsecase;

  LocalSignUp({required this.fetchAuthUsecase, required this.saveAuthUsecase});
  @override
  Future<void> call({required SignUpUsecaseParams params}) async {
    try {
      final localParams = LocalSignUpUsecaseParams.fromDomain(params: params);
      final savedUser = await fetchAuthUsecase(email: localParams.email);
      if (savedUser == null) {
        await saveAuthUsecase(authEntity: AuthEntity(email: localParams.email, password: localParams.password));
      } else {
        throw UserAlreadyExists();
      }
    } catch (e) {
      throw ModelError(error: e);
    }
  }
}

class LocalSignUpUsecaseParams {
  final String email;
  final String password;

  const LocalSignUpUsecaseParams({
    required this.email,
    required this.password,
  });

  factory LocalSignUpUsecaseParams.fromDomain({
    required SignUpUsecaseParams params,
  }) =>
      LocalSignUpUsecaseParams(
        email: params.email,
        password: params.password,
      );
}
