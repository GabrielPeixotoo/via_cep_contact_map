import 'package:via_cep_contacts_projects_uex/shared/data/data.dart';

import '../../../domain/domain.dart';

class LocalLogin implements LoginUsecase {
  final FetchUserUsecase fetchAuthUsecase;
  final SaveUserUsecase saveAuthUsecase;
  LocalLogin({
    required this.fetchAuthUsecase,
    required this.saveAuthUsecase,
  });
  @override
  Future<void> call({required AuthEntity authEntity}) async {
    try {
      final savedUser = await fetchAuthUsecase(email: authEntity.email);
      if (savedUser == null) {
        await saveAuthUsecase(authEntity: authEntity);
      } else {
        throw UserAlreadyExists();
      }
    } catch (e) {
      throw ModelError(error: e);
    }
  }
}
