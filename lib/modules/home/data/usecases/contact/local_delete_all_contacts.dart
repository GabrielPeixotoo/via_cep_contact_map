import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

class LocalDeleteAllContacts implements DeleteAllContactsUsecase {
  final LocalStorage localStorage;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;

  LocalDeleteAllContacts({
    required this.localStorage,
    required this.fetchCurrentUserUsecase,
  });

  @override
  Future<void> call() async {
    try {
      final user = await fetchCurrentUserUsecase.call();
      await localStorage.delete(key: user.email);
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
