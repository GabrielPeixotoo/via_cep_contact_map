import 'dart:convert';

import '../../../shared.dart';

class LocalSaveUser implements SaveUserUsecase {
  final LocalStorage localStorage;
  final FetchUsersUsecase fetchUsersUsecase;

  LocalSaveUser({
    required this.localStorage,
    required this.fetchUsersUsecase,
  });

  @override
  Future<void> call({required AuthEntity authEntity}) async {
    try {
      final users = await fetchUsersUsecase();
      users.add(authEntity);
      final contactsModel = users.map((user) => AuthModel.fromEntity(authEntity: user).toMap()).toList();
      await localStorage.save(key: StorageKeys.users, value: jsonEncode(contactsModel));
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
