import '../../../shared.dart';

class LocalSignUp implements SignUpUsecase {
  final FetchUserUsecase fetchAuthUsecase;
  final SaveUserUsecase saveAuthUsecase;

  LocalSignUp({required this.fetchAuthUsecase, required this.saveAuthUsecase});
  @override
  Future<void> call({required SignUpUsecaseParams params}) async {
    try {
      final localParams = LocalSignUpUsecaseParams.fromDomain(params: params);
      final savedUser = await fetchAuthUsecase(username: localParams.username);
      if (savedUser == null) {
        await saveAuthUsecase(authEntity: AuthEntity(username: localParams.username, password: localParams.password));
      } else {
        throw UserAlreadyExists();
      }
    } catch (e) {
      throw ModelError(error: e);
    }
  }
}

class LocalSignUpUsecaseParams {
  final String username;
  final String password;

  const LocalSignUpUsecaseParams({
    required this.username,
    required this.password,
  });

  factory LocalSignUpUsecaseParams.fromDomain({
    required SignUpUsecaseParams params,
  }) =>
      LocalSignUpUsecaseParams(
        username: params.username,
        password: params.password,
      );
}
