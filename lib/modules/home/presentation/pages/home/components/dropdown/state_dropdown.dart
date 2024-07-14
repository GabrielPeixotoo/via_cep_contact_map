import 'package:flutter/material.dart';

import '../../../../../../../shared/shared.dart';
import '../../../../../domain/domain.dart';
import '../../../pages.dart';

class StateDropdown extends StatefulWidget {
  final ContactFormController controller;
  final String? initialValue;
  const StateDropdown({super.key, required this.controller, this.initialValue});

  @override
  State<StateDropdown> createState() => _StateDropdownState();
}

class _StateDropdownState extends State<StateDropdown> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.controller.stateNotifier,
      builder: (context, stateValue, child) => InputDecorator(
        decoration: dropDownInputDecoration,
        isFocused: stateValue.isNotEmpty,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: stateValue.isEmpty ? null : stateValue,
            hint: const Text(
              'Selecione o estado do contato',
              textAlign: TextAlign.start,
            ),
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                widget.controller.onChangedState(newValue!);
              });
            },
            items: brazilianStates
                .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  InputDecoration get dropDownInputDecoration => InputDecoration(
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        alignLabelWithHint: true,
        border: InputBorder.none,
        enabledBorder: colorBorder(),
        focusedBorder: colorBorder(),
        disabledBorder: colorBorder(),
        focusedErrorBorder: colorBorder(),
        labelStyle: AppTextTheme.title1.copyWith(color: AppColors.black),
        floatingLabelStyle: AppTextTheme.title1.copyWith(
          color: AppColors.black,
        ),
      );

  OutlineInputBorder colorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: AppColors.black,
        ),
      );
}
