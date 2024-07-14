import 'package:flutter/material.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/home.dart';

import '../../../../../../shared/shared.dart';
import '../../../../domain/domain.dart';

class HomeController extends ValueNotifier<HomeState> {
  final AppNavigator appNavigator;
  final UIHelper uiHelper;
  final FetchContactsUsecase fetchContactsUsecase;
  final FetchCurrentUserUsecase fetchCurrentUserUsecase;
  final DeleteAllContactsUsecase deleteAllContactsUsecase;
  final DeleteContactUsecase deleteContactUsecase;
  final DeleteCurrentUserUsecase deleteCurrentUserUsecase;

  HomeController({
    required this.appNavigator,
    required this.uiHelper,
    required this.fetchContactsUsecase,
    required this.fetchCurrentUserUsecase,
    required this.deleteAllContactsUsecase,
    required this.deleteContactUsecase,
    required this.deleteCurrentUserUsecase,
  }) : super(HomeState.initial());

  final queryTextController = CustomTextEditingController();

  Future<String> fetchCurrentUsername() async {
    final auth = await fetchCurrentUserUsecase();
    return auth.email;
  }

  Future<void> fetchContacts() async {
    try {
      value = HomeState.loadingState();
      final contacts = await fetchContactsUsecase.call();
      value = HomeState.success(contacts: contacts, filteredContacts: []);
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

  Future<void> editContact({required ContactEntity contact}) async {
    await uiHelper.showCustomDialog(
        dialog: ContactFormDialog(
      contactEntity: contact,
    ));

    fetchContacts();
  }

  Future<void> deleteContact({required ContactEntity contact}) async {
    await deleteContactUsecase(contactEntity: contact);
    fetchContacts();
  }

  bool ascendingFilter = true;

  void onChangedSearch() {
    final state = value;
    if (state is SuccessState) {
      if (queryTextController.text.isNotEmpty) {
        final filteredContacts = state.contacts
            .where((contact) =>
                contact.name.toLowerCase().contains(queryTextController.text) ||
                contact.cpf.toLowerCase().contains(queryTextController.text))
            .toList();
        value = state.copyWith(filteredContacts: filteredContacts);
      } else {
        value = state.copyWith(filteredContacts: []);
      }
    }
  }

  bool isFiltering() => queryTextController.text.isNotEmpty;

  String emptyStateString() =>
      isFiltering() ? 'Não foi encontrado um contato com esse nome ou CPF.' : 'Cadastre um contato.';

  void clearInput() => queryTextController.text = '';

  void changeFilter() {
    final state = value;
    ascendingFilter = !ascendingFilter;
    if (state is SuccessState) {
      final contacts = state.contacts;
      contacts.sort((a, b) {
        if (ascendingFilter) {
          return a.name.compareTo(b.name);
        } else {
          return b.name.compareTo(a.name);
        }
      });
      value = state.copyWith(contacts: contacts);
    }
  }

  Future<void> logout() async {
    await deleteCurrentUserUsecase();
    appNavigator.pushAndClearStack(AppRoutes.loginPage);
  }
}
