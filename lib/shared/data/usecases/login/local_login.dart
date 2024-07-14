import 'package:via_cep_contacts_projects_uex/shared/data/data.dart';

import '../../../domain/domain.dart';

class LocalLogin implements LoginUsecase {
  final FetchUsersUsecase fetchUsersUsecase;
  final SaveCurrentUserUsecase saveCurrentUserUsecase;
  LocalLogin({
    required this.fetchUsersUsecase,
    required this.saveCurrentUserUsecase,
  });
  @override
  Future<void> call({required AuthEntity newLoginUser}) async {
    try {
      final usersInDatabase = await fetchUsersUsecase();
      bool foundUser = false;
      for (final user in usersInDatabase) {
        if (user == newLoginUser) {
          foundUser = true;
          await saveCurrentUserUsecase(user: newLoginUser);
          break;
        }
      }
      if (!foundUser) {
        throw UserNotFound();
      }
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
