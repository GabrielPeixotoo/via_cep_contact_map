import '../../../shared.dart';

class LocalSignUp implements SignUpUsecase {
  final FetchUsersUsecase fetchUsersUsecase;
  final SaveUserUsecase saveUserUsecase;

  LocalSignUp({required this.fetchUsersUsecase, required this.saveUserUsecase});
  @override
  Future<void> call({required SignUpUsecaseParams params}) async {
    try {
      final localParams = LocalSignUpUsecaseParams.fromDomain(params: params);
      final usersInDatabase = await fetchUsersUsecase();

      for (final user in usersInDatabase) {
        if (user.email == localParams.email) {
          throw UserAlreadyExists();
        }
      }

      await saveUserUsecase(authEntity: AuthEntity(email: localParams.email, password: localParams.password));
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
