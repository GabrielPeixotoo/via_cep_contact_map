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
                          CustomTextField(label: 'Estado', controller: _controller.stateTextController),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Cidade', controller: _controller.cityTextController),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Endereço', controller: _controller.addressTextController),
                          const SizedBox(height: 16),
                          AddressAutocomplete(contactFormController: _controller),
                          const SizedBox(height: 16),
                          CustomTextField(label: 'Complemento', controller: _controller.complementTextController),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: _controller.addContact,
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

class AddressAutocomplete extends StatelessWidget {
  final ContactFormController contactFormController;
  const AddressAutocomplete({super.key, required this.contactFormController});

  @override
  Widget build(BuildContext context) {
    return Autocomplete<AddressEntity>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<AddressEntity>.empty();
        }

        try {
          return await contactFormController.onChangedCep(textEditingValue.text);
        } catch (e) {
          return const Iterable<AddressEntity>.empty();
        }
      },
      onSelected: (AddressEntity selection) {
        // Handle selection of a suggestion
        print('Selected suggestion: $selection');
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            labelText: 'CEP',
          ),
          onChanged: (_) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder:
          (BuildContext context, AutocompleteOnSelected<AddressEntity> onSelected, Iterable<AddressEntity> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              height: 200.0,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: options
                    .map((AddressEntity address) => ListTile(
                          title: Text(address.streetName),
                          onTap: () {
                            onSelected(address);
                          },
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
