import '../../../shared.dart';

class LocalDeleteAuth implements DeleteAuthUsecase {
  final LocalStorage localStorage;

  LocalDeleteAuth({
    required this.localStorage,
  });

  @override
  Future<void> call() async {
    await localStorage.delete(key: StorageKeys.authEntity);
  }
}
