import '../../../shared.dart';

class LocalDeleteUser implements DeleteUserUsecase {
  final LocalStorage localStorage;

  LocalDeleteUser({
    required this.localStorage,
  });

  @override
  Future<void> call({required AuthEntity user}) async {
    await localStorage.delete(key: user.email);
  }
}
