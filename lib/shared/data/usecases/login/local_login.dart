import 'package:via_cep_contacts_projects_uex/shared/data/data.dart';

import '../../../domain/domain.dart';

class LocalLogin implements LoginUsecase {
  final FetchUserUsecase fetchUserUsecase;
  final SaveCurrentUserUsecase saveCurrentUserUsecase;
  LocalLogin({
    required this.fetchUserUsecase,
    required this.saveCurrentUserUsecase,
  });
  @override
  Future<void> call({required AuthEntity authEntity}) async {
    try {
      final savedUser = await fetchUserUsecase(email: authEntity.email);
      if (authEntity == savedUser) {
        await saveCurrentUserUsecase(user: authEntity);
      } else {
        throw UserNotFound();
      }
    } catch (e) {
      throw ModelError(error: e);
    }
  }
}
