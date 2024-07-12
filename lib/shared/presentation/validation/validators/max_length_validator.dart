import '../validation.dart';

class MaxLengthValidator implements Validator {
  final int maxLength;

  MaxLengthValidator({
    required this.maxLength,
  });

  @override
  ValidationError? call(String? value) =>
      (value?.length ?? 0) > maxLength ? ValidationError.invalidField : null;
}
