import 'package:equatable/equatable.dart';

abstract class ContactFormState {
  factory ContactFormState.initial({required List<String> suggestedCeps}) = ContactFormInitialState;
  factory ContactFormState.loading() = ContactFormLoadingState;
  factory ContactFormState.validated() = ContactFormValidatedState;
}

class ContactFormInitialState extends Equatable implements ContactFormState {
  final List<String> suggestedCeps;

  const ContactFormInitialState({required this.suggestedCeps});
  @override
  List<Object> get props => [suggestedCeps];

  ContactFormInitialState copyWith({
    List<String>? suggestedCeps,
  }) {
    return ContactFormInitialState(
      suggestedCeps: suggestedCeps ?? this.suggestedCeps,
    );
  }
}

class ContactFormLoadingState extends Equatable implements ContactFormState {
  @override
  List<Object> get props => [];
}

class ContactFormValidatedState extends Equatable implements ContactFormState {
  @override
  List<Object> get props => [];
}
