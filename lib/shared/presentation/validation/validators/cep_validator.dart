import '../validation.dart';

class CepValidator extends Validator {
  @override
  ValidationError? call(String? value) {
    RegExp regExp = RegExp(r'^\d{8}$');
    final isValid = regExp.hasMatch(value ?? '');
    return isValid ? null : ValidationError.invalidCep;
  }
}
