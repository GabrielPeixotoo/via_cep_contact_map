import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  Widget build(BuildContext context) => Dialog(
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
                    CustomTextField(label: 'CEP', controller: _controller.cepTextController),
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
          )));
}
