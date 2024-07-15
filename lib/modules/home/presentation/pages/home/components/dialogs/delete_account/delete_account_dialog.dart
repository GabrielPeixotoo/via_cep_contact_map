import 'package:flutter/material.dart';

import '../../../../../../../../shared/shared.dart';
import '../../../../../../home.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final controller = InjectionContainer.instance.get<DeleteAccountController>();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) => Dialog(
            backgroundColor: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColors.greyLight),
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: ListView(
                        children: [
                          Text(
                            'A apagamento da sua conta e dados é irreversível, tem certeza? Digite a sua senha para confirmar',
                            style: AppTextTheme.title2.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            label: 'Senha',
                            controller: controller.passwordTextController,
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                              onPressed:
                                  value is DeleteAccountValidatedState ? () => controller.deleteAccountAndData() : null,
                              child: const Text(
                                'Deletar conta e dados',
                                style: AppTextTheme.button1,
                              ))
                        ],
                      ),
                    ),
                    const Positioned(
                        top: -100,
                        child: Icon(
                          Icons.delete_forever,
                          size: 150,
                          color: AppColors.red,
                        ))
                  ],
                ))),
      );
}
