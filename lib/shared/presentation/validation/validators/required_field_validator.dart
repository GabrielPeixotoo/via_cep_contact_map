import '../validation.dart';

class RequiredFieldValidator extends Validator {
  @override
  ValidationError? call(String? value) =>
      (value?.isEmpty ?? true) ? ValidationError.required : null;
}
