import '../../../shared.dart';

class LocalFetchAuth implements FetchAuthUsecase {
  final LocalStorage localStorage;

  LocalFetchAuth({
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
