import '../../../shared.dart';

class LocalFetchUser implements FetchUserUsecase {
  final LocalStorage localStorage;

  LocalFetchUser({
    required this.localStorage,
  });

  @override
  Future<AuthEntity?> call({required String email}) async {
    final String json = await localStorage.fetch(key: email);
    if (json.isEmpty) {
      return null;
    }
    return AuthModel.fromJson(json: json).toEntity();
  }
}
