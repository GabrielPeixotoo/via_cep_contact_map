import 'package:flutter/material.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/home.dart';

import '../../../../../../shared/shared.dart';
import '../../../../domain/domain.dart';

class HomeController extends ValueNotifier<HomeState> {
  final UIHelper uiHelper;
  final FetchContactsUsecase fetchContactsUsecase;
  final DeleteAllContactsUsecase deleteAllContactsUsecase;
  final DeleteContactUsecase deleteContactUsecase;

  HomeController({
    required this.uiHelper,
    required this.fetchContactsUsecase,
    required this.deleteAllContactsUsecase,
    required this.deleteContactUsecase,
  }) : super(HomeState.initial());

  Future<void> fetchContacts() async {
    try {
      value = HomeState.loadingState();
      final contacts = await fetchContactsUsecase.call();
      value = HomeState.success(contacts: contacts);
    } catch (_) {
      uiHelper.showCustomSnackBar(
          snackBar:
              makeSnackBar(icon: Icons.error, text: 'Ocorreu um erro no processamento', backgroundColor: Colors.red));
    }
  }

  Future<void> openCreateContactDialog() async {
    await uiHelper.showCustomDialog(dialog: const ContactFormDialog());

    fetchContacts();
  }
}
