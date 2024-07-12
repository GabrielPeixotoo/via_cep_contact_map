import '../../../shared.dart';

abstract class Validator {
  ValidationError? call(String? value);
}

class MultiValidator {
  final List<Validator> validators;

  MultiValidator({
    required this.validators,
  });

  String? call(String? value) {
    final result = validate(value);

    return result.isEmpty ? null : result.first.message;
  }

  List<ValidationError> validate(String? value) {
    final result = <ValidationError>[];

    for (final validator in validators) {
      final error = validator(value);

      if (error != null) {
        result.add(error);
      }
    }

    return result;
  }
}
