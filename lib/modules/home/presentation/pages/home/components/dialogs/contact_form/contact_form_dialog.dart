import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/domain/domain.dart';

import '../../../../../../../../shared/shared.dart';
import '../../../../pages.dart';

class ContactFormDialog extends StatefulWidget {
  const ContactFormDialog({super.key});

  @override
  State<ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final _controller = InjectionContainer.instance.get<ContactFormController>();
  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) => Dialog(
            backgroundColor: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.greyLight),
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: ListView(
                        children: [
                          CustomTextField(
                            label: 'Nome',
                            controller: _controller.nameTextController,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'CPF',
                            controller: _controller.cpfTextController,
                            inputFormatters: [MaskTextInputFormatter().formatToCpf()],
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Telefone',
                            controller: _controller.phoneTextController,
                            inputFormatters: [PhoneNumberMaskTextInputFormatter()],
                          ),
                          const SizedBox(height: 16),
                          StateDropdown(
                            controller: _controller,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Cidade', controller: _controller.cityTextController),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Endereço', controller: _controller.addressTextController),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'CEP',
                            controller: _controller.cepTextController,
                            onChanged: (_) => _controller.onChangedCep(),
                            maxLength: 8,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Complemento', controller: _controller.complementTextController),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: value is ContactFormValidatedState ? _controller.addContact : null,
                            child: const Text(
                              'Adicionar contato',
                              style: AppTextTheme.button1,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Positioned(
                        top: -100,
                        child: Icon(
                          Icons.contact_mail,
                          size: 150,
                          color: Colors.lightBlue,
                        ))
                  ],
                ))),
      );
}

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
