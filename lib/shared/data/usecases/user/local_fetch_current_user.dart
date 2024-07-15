import '../../../shared.dart';

class LocalFetchCurrentUser implements FetchCurrentUserUsecase {
  final LocalStorage localStorage;

  LocalFetchCurrentUser({required this.localStorage});

  @override
  Future<AuthEntity> call() async {
    final String json = await localStorage.fetch(key: StorageKeys.currentUserEntity);

    return AuthModel.fromJson(json: json);
  }
}
