import '../../../shared.dart';

class LocalSaveUser implements SaveUserUsecase {
  final LocalStorage localStorage;

  LocalSaveUser({
    required this.localStorage,
  });

  @override
  Future<void> call({required AuthEntity authEntity}) async {
    final encodedModel = AuthModel.fromEntity(authEntity: authEntity).toJson();

    await localStorage.save(key: authEntity.email, value: encodedModel);
  }
}
