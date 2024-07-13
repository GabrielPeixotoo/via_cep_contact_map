import 'package:equatable/equatable.dart';

abstract class SignUpUsecase {
  Future<void> call({required SignUpUsecaseParams params});
}

class SignUpUsecaseParams extends Equatable {
  final String username;
  final String password;

  const SignUpUsecaseParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [
        username,
        password,
      ];
}
