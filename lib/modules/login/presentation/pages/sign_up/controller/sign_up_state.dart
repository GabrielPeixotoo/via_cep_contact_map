import 'package:equatable/equatable.dart';

abstract class SignUpState {
  factory SignUpState.initial() = LoginInitialState;
  factory SignUpState.loading() = LoginLoadingState;
  factory SignUpState.validated() = LoginValidatedState;
}

class LoginInitialState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}

class LoginValidatedState extends Equatable implements SignUpState {
  @override
  List<Object> get props => [];
}
