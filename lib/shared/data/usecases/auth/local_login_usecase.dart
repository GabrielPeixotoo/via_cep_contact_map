import 'package:via_cep_contacts_projects_uex/shared/data/data.dart';

import '../../../domain/domain.dart';

class LocalLoginUsecase implements LoginUsecase {
  final FetchAuthUsecase fetchAuthUsecase;
  final SaveAuthUsecase saveAuthUsecase;
  LocalLoginUsecase({
    required this.fetchAuthUsecase,
    required this.saveAuthUsecase,
  });
  @override
  Future<void> call({required AuthEntity authEntity}) async {
    try {
      final savedUser = await fetchAuthUsecase(username: authEntity.username);
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
