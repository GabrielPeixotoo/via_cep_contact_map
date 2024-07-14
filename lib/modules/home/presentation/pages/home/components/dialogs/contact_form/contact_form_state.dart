import 'package:equatable/equatable.dart';

abstract class ContactFormState {
  factory ContactFormState.initial() = ContactFormInitialState;
  factory ContactFormState.loading() = ContactFormLoadingState;
  factory ContactFormState.validated() = ContactFormValidatedState;
}

class ContactFormInitialState extends Equatable implements ContactFormState {
  @override
  List<Object> get props => [];
}

class ContactFormLoadingState extends Equatable implements ContactFormState {
  @override
  List<Object> get props => [];
}

class ContactFormValidatedState extends Equatable implements ContactFormState {
  @override
  List<Object> get props => [];
}
