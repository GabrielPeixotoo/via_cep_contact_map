import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/domain/domain.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/home.dart';
import 'package:via_cep_contacts_projects_uex/shared/shared.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

class MockUIHelper extends Mock implements UIHelper {}

class MockFetchContactsUsecase extends Mock implements FetchContactsUsecase {}

class MockFetchCurrentUserUsecase extends Mock implements FetchCurrentUserUsecase {}

class MockDeleteAllContactsUsecase extends Mock implements DeleteAllContactsUsecase {}

class MockDeleteContactUsecase extends Mock implements DeleteContactUsecase {}

class MockDeleteCurrentUserUsecase extends Mock implements DeleteCurrentUserUsecase {}

void main() {
  late HomeController homeController;
  late MockAppNavigator mockAppNavigator;
  late MockUIHelper mockUIHelper;
  late MockFetchContactsUsecase mockFetchContactsUsecase;
  late MockFetchCurrentUserUsecase mockFetchCurrentUserUsecase;
  late MockDeleteAllContactsUsecase mockDeleteAllContactsUsecase;
  late MockDeleteContactUsecase mockDeleteContactUsecase;
  late MockDeleteCurrentUserUsecase mockDeleteCurrentUserUsecase;

  setUp(() {
    mockAppNavigator = MockAppNavigator();
    mockUIHelper = MockUIHelper();
    mockFetchContactsUsecase = MockFetchContactsUsecase();
    mockFetchCurrentUserUsecase = MockFetchCurrentUserUsecase();
    mockDeleteAllContactsUsecase = MockDeleteAllContactsUsecase();
    mockDeleteContactUsecase = MockDeleteContactUsecase();
    mockDeleteCurrentUserUsecase = MockDeleteCurrentUserUsecase();

    homeController = HomeController(
      appNavigator: mockAppNavigator,
      uiHelper: mockUIHelper,
      fetchContactsUsecase: mockFetchContactsUsecase,
      fetchCurrentUserUsecase: mockFetchCurrentUserUsecase,
      deleteAllContactsUsecase: mockDeleteAllContactsUsecase,
      deleteContactUsecase: mockDeleteContactUsecase,
      deleteCurrentUserUsecase: mockDeleteCurrentUserUsecase,
    );
  });

  setUpAll(() {
    registerFallbackValue(Container());
    registerFallbackValue(SnackBar(
      content: Container(),
    ));
  });

  group('HomeController', () {
    test('fetchCurrentUsername returns the current user email', () async {
      const auth = AuthEntity(email: 'test@example.com', password: 'password');
      when(() => mockFetchCurrentUserUsecase()).thenAnswer((_) async => auth);

      final result = await homeController.fetchCurrentUsername();

      expect(result, auth.email);
      verify(() => mockFetchCurrentUserUsecase()).called(1);
    });

    test('fetchContacts sets the state to success with contacts', () async {
      final contacts = [
        ContactEntity(name: 'John Doe', cpf: '123456789', addressEntity: AddressEntity.empty(), phone: '')
      ];
      when(() => mockFetchContactsUsecase()).thenAnswer((_) async => contacts);

      await homeController.fetchContacts();

      expect(homeController.value, isA<SuccessState>());
      final state = homeController.value as SuccessState;
      expect(state.contacts, contacts);
      verify(() => mockFetchContactsUsecase()).called(1);
    });

    test('fetchContacts shows error snackbar on failure', () async {
      when(() => mockFetchContactsUsecase()).thenThrow(Exception());
      when(() => mockUIHelper.showCustomSnackBar(snackBar: any(named: 'snackBar'))).thenAnswer((_) async => {});

      await homeController.fetchContacts();

      verify(() => mockUIHelper.showCustomSnackBar(snackBar: any(named: 'snackBar'))).called(1);
    });

    test('openCreateContactDialog shows dialog and fetches contacts', () async {
      when(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).thenAnswer((_) async => {});
      when(() => mockFetchContactsUsecase()).thenAnswer((_) async => []);

      await homeController.openCreateContactDialog();

      verify(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).called(1);
      verify(() => mockFetchContactsUsecase()).called(1);
    });

    test('editContact shows dialog and fetches contacts', () async {
      final contact =
          ContactEntity(name: 'John Doe', cpf: '123456789', addressEntity: AddressEntity.empty(), phone: '');
      when(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).thenAnswer((_) async => {});
      when(() => mockFetchContactsUsecase()).thenAnswer((_) async => []);

      await homeController.editContact(contact: contact);

      verify(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).called(1);
      verify(() => mockFetchContactsUsecase()).called(1);
    });

    test('deleteContact deletes contact and fetches contacts', () async {
      final contact =
          ContactEntity(name: 'John Doe', cpf: '123456789', addressEntity: AddressEntity.empty(), phone: '');
      when(() => mockDeleteContactUsecase(contactEntity: contact)).thenAnswer((_) async => {});
      when(() => mockFetchContactsUsecase()).thenAnswer((_) async => []);

      await homeController.deleteContact(contact: contact);

      verify(() => mockDeleteContactUsecase(contactEntity: contact)).called(1);
      verify(() => mockFetchContactsUsecase()).called(1);
    });

    test('onChangedSearch filters contacts', () async {
      final contacts = [
        ContactEntity(name: 'John Doe', cpf: '123456789', addressEntity: AddressEntity.empty(), phone: ''),
        ContactEntity(name: 'Jane Doe', cpf: '987654321', addressEntity: AddressEntity.empty(), phone: '')
      ];
      final state = SuccessState(contacts: contacts, filteredContacts: []);
      homeController.value = state;
      homeController.queryTextController.text = 'john';

      homeController.onChangedSearch();

      final newState = homeController.value as SuccessState;
      expect(newState.filteredContacts.length, 1);
      expect(newState.filteredContacts.first.name, 'John Doe');
    });

    test('changeFilter toggles the filter order', () async {
      final contacts = [
        ContactEntity(name: 'John Doe', cpf: '123456789', addressEntity: AddressEntity.empty(), phone: ''),
        ContactEntity(name: 'Jane Doe', cpf: '987654321', addressEntity: AddressEntity.empty(), phone: '')
      ];
      final state = SuccessState(contacts: contacts, filteredContacts: []);
      homeController.value = state;

      homeController.changeFilter();
      expect(homeController.ascendingFilter, isFalse);

      homeController.changeFilter();
      expect(homeController.ascendingFilter, isTrue);
    });

    test('showDeleteAccountDialog shows dialog and navigates to login', () async {
      when(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).thenAnswer((_) async => {});
      when(() => mockAppNavigator.pushAndClearStack(AppRoutes.loginPage)).thenAnswer((_) async => {});

      await homeController.showDeleteAccountDialog();

      verify(() => mockUIHelper.showCustomDialog(dialog: any(named: 'dialog'))).called(1);
      verify(() => mockAppNavigator.pushAndClearStack(AppRoutes.loginPage)).called(1);
    });

    test('logout deletes current user and navigates to login', () async {
      when(() => mockDeleteCurrentUserUsecase()).thenAnswer((_) async => {});
      when(() => mockAppNavigator.pushAndClearStack(AppRoutes.loginPage)).thenAnswer((_) async => {});

      await homeController.logout();

      verify(() => mockDeleteCurrentUserUsecase()).called(1);
      verify(() => mockAppNavigator.pushAndClearStack(AppRoutes.loginPage)).called(1);
    });
  });
}
