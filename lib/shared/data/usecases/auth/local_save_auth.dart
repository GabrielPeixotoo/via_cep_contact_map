import '../../../shared.dart';

class LocalSaveAuth implements SaveAuthUsecase {
  final LocalStorage localStorage;

  LocalSaveAuth({
    required this.localStorage,
  });

  @override
  Future<void> call({required AuthEntity authEntity}) async {
    final encodedModel = AuthModel.fromEntity(authEntity: authEntity).toJson();

    await localStorage.save(key: StorageKeys.authEntity, value: encodedModel);
  }
}
