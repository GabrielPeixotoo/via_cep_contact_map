import 'dart:convert';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../models/models.dart';

class LocalSaveContact implements SaveContactUsecase {
  final LocalStorage localStorage;
  final FetchContactsUsecase fetchContactsUsecase;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;

  LocalSaveContact({
    required this.localStorage,
    required this.fetchContactsUsecase,
    required this.fetchCurrentUserUsecase,
  });
  @override
  Future<void> call({required ContactEntity contactEntity}) async {
    try {
      final user = await fetchCurrentUserUsecase();
      final contacts = await fetchContactsUsecase();
      contacts.add(contactEntity);
      final contactsModel = contacts.map((contact) => ContactModel.fromEntity(contactEntity: contact).toMap()).toList();
      await localStorage.save(key: user.email, value: jsonEncode(contactsModel));
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
