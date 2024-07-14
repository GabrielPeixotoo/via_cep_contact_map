import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

class LocalDeleteContact implements DeleteContactUsecase {
  final LocalStorage localStorage;
  final FetchContactsUsecase fetchContactsUsecase;
  final SaveContactUsecase saveContactUsecase;

  LocalDeleteContact(
      {required this.localStorage, required this.fetchContactsUsecase, required this.saveContactUsecase});

  @override
  Future<void> call({required ContactEntity contactEntity}) async {
    try {} on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
