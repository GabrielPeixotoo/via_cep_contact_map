import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';
import '../pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _controller = InjectionContainer.instance.get<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
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
                        CustomTextField(
                          label: 'Email',
                          controller: _controller.emailTextField,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          label: 'Senha',
                          obscureText: true,
                          controller: _controller.passwordTextField,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 32.0),
                        ElevatedButton(
                          onPressed: isValid ? _controller.register : null,
                          child: const Text(
                            'Realizar cadastro',
                            style: AppTextTheme.button1,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _controller.goToLoginPage,
                          child: const Text(
                            'Ir para Login',
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
