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
                          CustomTextField(
                            label: 'Cidade',
                            controller: _controller.cityTextController,
                            onChanged: (_) => _controller.onChangedAddress(),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Endereço',
                            controller: _controller.addressTextController,
                            onChanged: (_) => _controller.onChangedAddress(),
                          ),
                          const SizedBox(height: 16),
                          if (value is ContactFormInitialState)
                            _SuggestedCepsList(
                              ceps: value.suggestedCeps,
                              onTap: _controller.onTapCep,
                            ),
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
                              child: value is ContactFormLoadingState
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Adicionar contato',
                                      style: AppTextTheme.button1,
                                    ))
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

class _SuggestedCepsList extends StatelessWidget {
  final List<String> ceps;
  final ValueChanged<String> onTap;
  const _SuggestedCepsList({
    required this.ceps,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Visibility(
        visible: ceps.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ListView(shrinkWrap: true, children: [
            const Text('Sugestões de CEP'),
            ...ceps.map((cep) => InkWell(
                  onTap: () => onTap(cep),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cep),
                  ),
                )),
          ]),
        ),
      );
}
