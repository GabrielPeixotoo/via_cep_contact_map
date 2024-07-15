// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../domain/domain.dart';

abstract class HomeState {
  factory HomeState.initial() = InitialState;
  factory HomeState.loadingState() = InitialState;
  factory HomeState.success({required List<ContactEntity> contacts, required List<ContactEntity> filteredContacts}) =
      SuccessState;
}

class InitialState implements HomeState {
  InitialState();
}

class LoadingState implements HomeState {
  LoadingState();
}

class SuccessState implements HomeState {
  final List<ContactEntity> contacts;
  final List<ContactEntity> filteredContacts;
  SuccessState({required this.contacts, required this.filteredContacts});

  SuccessState copyWith({
    List<ContactEntity>? contacts,
    List<ContactEntity>? filteredContacts,
  }) {
    return SuccessState(
      contacts: contacts ?? this.contacts,
      filteredContacts: filteredContacts ?? this.filteredContacts,
    );
  }
}
