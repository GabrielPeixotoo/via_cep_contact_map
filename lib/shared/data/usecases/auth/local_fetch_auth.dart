import '../../../shared.dart';

class LocalFetchAuth implements FetchAuthUsecase {
  final LocalStorage localStorage;

  LocalFetchAuth({
    required this.localStorage,
  });

  @override
  Future<AuthEntity> call() async {
    final String enconded =
        await localStorage.fetch(key: StorageKeys.authEntity);

    return AuthModel.fromJson(json: enconded);
  }
}
