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
      final userExists = usersInDatabase.any((user) => user == newLoginUser);

      if (userExists) {
        await saveCurrentUserUsecase(user: newLoginUser);
      } else {
        throw UserNotFound();
      }
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
