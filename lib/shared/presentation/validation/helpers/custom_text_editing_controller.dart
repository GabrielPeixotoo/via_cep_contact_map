import 'package:flutter/cupertino.dart';

import '../../../shared.dart';

class CustomTextEditingController extends TextEditingController {
  final FormFieldValidator<String>? _validator;

  final ValueNotifier<String?> errorText = ValueNotifier(null);
  final ValueNotifier<bool> isValid = ValueNotifier(false);
  bool userInteraction = false;

  CustomTextEditingController({
    super.text,
    FormFieldValidator<String>? validator,
  }) : _validator = validator;

  void validate(String? value) {
    final result = _validator?.call(value);

    errorText.value = result;

    isValid.value = result == null && text.isNotEmpty;
  }

  @override
  void dispose() {
    errorText.dispose();
    isValid.dispose();
    super.dispose();
  }
}

class CustomMultiValidatorTextEditingController extends CustomTextEditingController {
  final MultiValidator validator;
  final ValueNotifier<List<ValidationError>> errors = ValueNotifier([]);

  CustomMultiValidatorTextEditingController({
    super.text,
    required this.validator,
  }) {
    errors.value = validator.validate('');
  }

  @override
  void validate(String? value) {
    final validationErrors = validator.validate(value);

    errorText.value = validationErrors.firstOrNull?.message;
    errors.value = validationErrors;

    isValid.value = validationErrors.isEmpty && text.isNotEmpty;
  }

  @override
  void dispose() {
    errors.dispose();
    super.dispose();
  }
}
