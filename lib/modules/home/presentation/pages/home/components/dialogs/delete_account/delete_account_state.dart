import 'package:equatable/equatable.dart';

abstract class DeleteAccountState {
  factory DeleteAccountState.initial() = DeleteAccountInitialState;
  factory DeleteAccountState.loading() = DeleteAccountLoadingState;
  factory DeleteAccountState.validated() = DeleteAccountValidatedState;
}

class DeleteAccountInitialState extends Equatable implements DeleteAccountState {
  const DeleteAccountInitialState();
  @override
  List<Object> get props => [];
}

class DeleteAccountLoadingState extends Equatable implements DeleteAccountState {
  @override
  List<Object> get props => [];
}

class DeleteAccountValidatedState extends Equatable implements DeleteAccountState {
  @override
  List<Object> get props => [];
}
