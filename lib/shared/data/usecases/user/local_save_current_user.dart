import '../../../shared.dart';

class LocalSaveCurrentUser implements SaveCurrentUserUsecase {
  final LocalStorage localStorage;

  LocalSaveCurrentUser({
    required this.localStorage,
  });

  @override
  Future<void> call({required AuthEntity user}) async {
    final encodedModel = AuthModel.fromEntity(authEntity: user).toJson();
    await localStorage.save(key: StorageKeys.currentUserEntity, value: encodedModel);
  }
}
