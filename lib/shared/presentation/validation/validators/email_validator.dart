import '../validation.dart';

class EmailValidator extends Validator {
  @override
  ValidationError? call(String? value) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    final isValid = regex.hasMatch(value ?? '');
    return isValid ? null : ValidationError.invalidEmail;
  }
}
