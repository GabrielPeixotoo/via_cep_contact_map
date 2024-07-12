import '../validation.dart';

class CpfValidator implements Validator {
  @override
  ValidationError? call(String? value) {
    final cpf = value?.replaceAll(RegExp('[^0-9]'), '') ?? '';

    final bool isValid = cpf.length == 11 &&
        _validateFirstDigit(cpf) &&
        _validateSecondDigit(cpf);

    return isValid ? null : ValidationError.invalidCpf;
  }

  bool _validateFirstDigit(String cpf) {
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }

    final digit = (sum * 10 % 11) % 10;

    return digit.toString() == cpf[9];
  }

  bool _validateSecondDigit(String cpf) {
    int sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }

    final digit = (sum * 10 % 11) % 10;

    return digit.toString() == cpf[10];
  }
}
