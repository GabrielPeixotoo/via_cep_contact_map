import '../../../shared.dart';

class LocalDeleteUser implements DeleteUserUsecase {
  final LocalStorage localStorage;

  LocalDeleteUser({
    required this.localStorage,
  });

  @override
  Future<void> call() async {
    await localStorage.delete(key: StorageKeys.authEntity);
  }
}
