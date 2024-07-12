import '../validation.dart';

class MinLengthValidator implements Validator {
  final int minLength;

  MinLengthValidator({
    required this.minLength,
  });

  @override
  ValidationError? call(String? value) =>
      (value?.length ?? 0) < minLength ? ValidationError.invalidField : null;
}
