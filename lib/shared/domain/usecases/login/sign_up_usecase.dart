import 'package:equatable/equatable.dart';

abstract class SignUpUsecase {
  Future<void> call({required SignUpUsecaseParams params});
}

class SignUpUsecaseParams extends Equatable {
  final String email;
  final String password;

  const SignUpUsecaseParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
