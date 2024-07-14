import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneNumberMaskTextInputFormatter extends MaskTextInputFormatter {
  static const String _landlineMask = '(##) ####-####';
  static const String _phoneMask = '(##) #####-####';

  PhoneNumberMaskTextInputFormatter({super.initialText})
      : super(
          mask: _landlineMask,
          filter: {'#': RegExp('[0-9]')},
          type: MaskAutoCompletionType.lazy,
        );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text.isNotEmpty) {
      _updateMask(newValue.text);
    }
    return super.formatEditUpdate(oldValue, newValue);
  }

  void _updateMask(String text) {
    final String? mask = getMask();
    final String numbers = text.replaceAll(RegExp('[^0-9]'), '');
    if (numbers.length <= 10) {
      if (mask != _landlineMask) {
        updateMask(mask: _landlineMask);
      }
    } else {
      if (mask != _phoneMask) {
        updateMask(mask: _phoneMask);
      }
    }
  }

  @override
  String maskText(String text) {
    _updateMask(text);
    return super.maskText(text);
  }
}
