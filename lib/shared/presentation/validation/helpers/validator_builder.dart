import '../../../shared.dart';

class ValidatorBuilder {
  final List<Validator> validators = [];

  ValidatorBuilder required() {
    validators.add(RequiredFieldValidator());
    return this;
  }

  ValidatorBuilder email() {
    validators.add(EmailValidator());
    return this;
  }

  ValidatorBuilder cpf() {
    validators.add(CpfValidator());
    return this;
  }

  ValidatorBuilder minLength(int min) {
    validators.add(MinLengthValidator(minLength: min));
    return this;
  }

  ValidatorBuilder maxLength(int max) {
    validators.add(MaxLengthValidator(maxLength: max));
    return this;
  }

  ValidatorBuilder phone() {
    validators.add(PhoneValidator());
    return this;
  }

  MultiValidator build() => MultiValidator(validators: validators);
}
