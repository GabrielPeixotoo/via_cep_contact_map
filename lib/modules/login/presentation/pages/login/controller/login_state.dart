import 'package:equatable/equatable.dart';

abstract class LoginState {
  factory LoginState.initial() = LoginInitialState;
  factory LoginState.loading() = LoginLoadingState;
  factory LoginState.validated() = LoginValidatedState;
}

class LoginInitialState extends Equatable implements LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends Equatable implements LoginState {
  @override
  List<Object> get props => [];
}

class LoginValidatedState extends Equatable implements LoginState {
  @override
  List<Object> get props => [];
}
