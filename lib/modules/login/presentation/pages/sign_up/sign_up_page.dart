import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';
import '../pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controller = InjectionContainer.instance.get<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        final isValid = value is SignUpValidatedState;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Bem-vindo a sua plataforma de gerenciamento de contatos!',
              style: AppTextTheme.subtitle1,
            ),
            centerTitle: true,
            backgroundColor: AppColors.blue,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    side: const BorderSide(color: AppColors.blue, width: 2.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const Text('Cadastro', style: AppTextTheme.subtitle1),
                        const SizedBox(height: 16.0),
                        CustomTextField(label: 'Email', controller: controller.emailTextField),
                        const SizedBox(height: 16.0),
                        CustomTextField(label: 'Senha', controller: controller.passwordTextField),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: isValid ? controller.register : null,
                          child: const Text(
                            'Realizar cadastro',
                            style: AppTextTheme.button1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
