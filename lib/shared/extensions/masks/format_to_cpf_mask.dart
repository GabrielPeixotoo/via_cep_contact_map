import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension CpfMaskFormatExtension on MaskTextInputFormatter {
  MaskTextInputFormatter formatToCpf({String? initialText}) => MaskTextInputFormatter(
        initialText: initialText,
        mask: '###.###.###-##',
        filter: {
          '#': RegExp('[0-9]'),
        },
      );
}
