import 'dart:convert';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../models/models.dart';

class LocalFetchContacts implements FetchContactsUsecase {
  final LocalStorage localStorage;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;

  LocalFetchContacts({
    required this.localStorage,
    required this.fetchCurrentUserUsecase,
  });
  @override
  Future<List<ContactEntity>> call() async {
    try {
      final user = await fetchCurrentUserUsecase();
      final contactsJson = await localStorage.fetch(key: user.email);

      if (contactsJson.isEmpty) {
        return [];
      }

      final List<dynamic> contactsMap = jsonDecode(contactsJson);
      final contactsModel = contactsMap.map((map) => ContactModel.fromMap(map: map)).toList();
      return contactsModel.map((model) => model.toEntity()).toList();
    } on CacheError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
