import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final CustomTextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? floatingLabelText;
  final bool enabled;
  final VoidCallback? onEditingComplete;
  final List<String>? autofillHints;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.visiblePassword,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.initialValue,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.floatingLabelText,
    this.enabled = true,
    this.onEditingComplete,
    this.autofillHints,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty && widget.initialValue?.isNotEmpty == true) {
      widget.controller.text = widget.initialValue!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller.validate(widget.controller.text);
      });
    }

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String?>(
        valueListenable: widget.controller.errorText,
        builder: (_, errorText, __) => TextFormField(
          controller: widget.controller,
          autofillHints: widget.autofillHints,
          onEditingComplete: () {
            widget.onEditingComplete?.call();
            _focusNode.unfocus();
          },
          onChanged: (text) {
            widget.controller.validate(text);
            widget.controller.userInteraction = true;
            widget.onChanged?.call(text);
          },
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          focusNode: _focusNode,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          obscureText: widget.obscureText,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: AppColors.black,
          style: AppTextTheme.title2.copyWith(
            color: AppColors.black,
          ),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            alignLabelWithHint: true,
            border: InputBorder.none,
            enabledBorder: colorBorder(errorText),
            focusedBorder: colorBorder(errorText),
            disabledBorder: colorBorder(errorText),
            errorBorder: colorBorder(errorText),
            focusedErrorBorder: colorBorder(errorText),
            labelStyle: AppTextTheme.title1.copyWith(color: AppColors.black),
            floatingLabelStyle: AppTextTheme.title1.copyWith(
              color: _changeBorderColor(errorText),
            ),
            errorText: errorText,
            labelText: _focusNode.hasFocus || widget.controller.text.isNotEmpty
                ? widget.floatingLabelText ?? widget.label
                : widget.label,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: widget.prefixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: widget.suffixIcon,
            ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
          ),
          obscuringCharacter: '*',
        ),
      );

  Color _changeBorderColor(String? errorText) {
    if (errorText == null && widget.controller.text.isEmpty) {
      return AppColors.greyDark;
    } else if (errorText != null) {
      return AppColors.red;
    } else {
      return AppColors.black;
    }
  }

  OutlineInputBorder colorBorder(String? errorText) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _changeBorderColor(errorText),
        ),
      );
}
