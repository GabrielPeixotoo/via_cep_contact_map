import 'dart:convert';

import '../../../shared.dart';

class LocalFetchUsers implements FetchUsersUsecase {
  final LocalStorage localStorage;

  LocalFetchUsers({
    required this.localStorage,
  });

  @override
  Future<List<AuthEntity>> call() async {
    try {
      final users = await localStorage.fetch(key: StorageKeys.users);

      if (users.isEmpty) {
        return [];
      }

      final List<dynamic> contactsMap = jsonDecode(users);
      final usersModel = contactsMap.map((map) => AuthModel.fromMap(map: map).toEntity()).toList();
      return usersModel;
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
