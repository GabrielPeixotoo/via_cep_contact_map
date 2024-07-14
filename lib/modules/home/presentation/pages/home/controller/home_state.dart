import '../../../../domain/domain.dart';

abstract class HomeState {
  factory HomeState.initial() = InitialState;
  factory HomeState.loadingState() = InitialState;
  factory HomeState.success({required List<ContactEntity> contacts}) = SuccessState;
}

class InitialState implements HomeState {
  InitialState();
}

class LoadingState implements HomeState {
  LoadingState();
}

class SuccessState implements HomeState {
  final List<ContactEntity> contacts;
  SuccessState({
    required this.contacts,
  });
}
