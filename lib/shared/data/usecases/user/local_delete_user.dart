import 'dart:convert';

import '../../../../../shared/shared.dart';

class LocalDeleteUser implements DeleteUserUsecase {
  final LocalStorage localStorage;
  final FetchUsersUsecase fetchUsersUsecase;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;

  LocalDeleteUser({
    required this.localStorage,
    required this.fetchUsersUsecase,
    required this.fetchCurrentUserUsecase,
  });
  @override
  Future<void> call({required String password}) async {
    try {
      final currentUser = await fetchCurrentUserUsecase();
      final users = await fetchUsersUsecase();

      final databaseUser = users.firstWhere((user) => user.email == currentUser.email);

      if (password != databaseUser.password) {
        throw WrongPassword();
      }

      users.removeWhere((user) => user.email == currentUser.email);

      final usersModel = users.map((user) => AuthModel.fromEntity(authEntity: user).toMap()).toList();
      await localStorage.save(key: StorageKeys.users, value: jsonEncode(usersModel));
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
