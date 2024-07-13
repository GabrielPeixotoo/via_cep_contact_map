import '../../../shared.dart';

class LocalFetchUser implements FetchUserUsecase {
  final LocalStorage localStorage;

  LocalFetchUser({
    required this.localStorage,
  });

  @override
  Future<AuthEntity?> call({required String username}) async {
    final String json = await localStorage.fetch(key: username);
    if (json.isEmpty) {
      return null;
    }
    return AuthModel.fromJson(json: json);
  }
}
