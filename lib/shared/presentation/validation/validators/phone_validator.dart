import '../validation.dart';

class PhoneValidator implements Validator {
  @override
  ValidationError? call(String? value) {
    final regex = RegExp(r'^\(\d{2}\) \d{4,5}-\d{4}$');
    final isValid = regex.hasMatch(value ?? '');
    return isValid ? null : ValidationError.invalidPhone;
  }
}
