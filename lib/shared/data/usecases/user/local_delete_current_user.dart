import '../../../shared.dart';

class LocalSaveCurrentUser implements SaveCurrentUserUsecase {
  final LocalStorage localStorage;

  LocalSaveCurrentUser({
    required this.localStorage,
  });

  @override
  Future<void> call({required AuthEntity user}) async {
    await localStorage.delete(key: StorageKeys.currentUserEntity);
  }
}
