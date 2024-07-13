import '../../../shared.dart';

class LocalSignUp implements SignUpUsecase {
  final FetchUserUsecase fetchUserUsecase;
  final SaveUserUsecase saveUserUsecase;

  LocalSignUp({required this.fetchUserUsecase, required this.saveUserUsecase});
  @override
  Future<void> call({required SignUpUsecaseParams params}) async {
    try {
      final localParams = LocalSignUpUsecaseParams.fromDomain(params: params);
      final savedUser = await fetchUserUsecase(email: localParams.email);
      if (savedUser == null) {
        await saveUserUsecase(authEntity: AuthEntity(email: localParams.email, password: localParams.password));
      } else {
        throw UserAlreadyExists();
      }
    } on CacheError {
      throw ModelError(message: 'Erro no cache');
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
