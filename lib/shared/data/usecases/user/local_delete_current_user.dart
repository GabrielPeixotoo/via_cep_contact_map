import '../../../shared.dart';

class LocalDeleteCurrentUser implements DeleteCurrentUserUsecase {
  final LocalStorage localStorage;

  LocalDeleteCurrentUser({
    required this.localStorage,
  });

  @override
  Future<void> call() async {
    await localStorage.delete(key: StorageKeys.currentUserEntity);
  }
}
