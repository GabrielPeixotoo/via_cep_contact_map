import 'package:equatable/equatable.dart';

abstract class SignUpState {
  factory SignUpState.initial() = SignUpInitialState;
  factory SignUpState.loading() = SignUpLoadingState;
  factory SignUpState.validated() = SignUpValidatedState;
}

class SignUpInitialState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoadingState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpValidatedState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}
