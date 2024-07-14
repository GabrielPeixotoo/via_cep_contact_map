import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';
import '../../../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = InjectionContainer.instance.get<HomeController>();

  @override
  void initState() {
    super.initState();
    controller.fetchContacts();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gerenciamento de contatos',
            style: AppTextTheme.subtitle1,
          ),
          centerTitle: true,
          backgroundColor: AppColors.blue,
        ),
        body: ValueListenableBuilder<HomeState>(
          valueListenable: controller,
          builder: (_, state, __) {
            if (state is LoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SuccessState) {
              final contacts = state.contacts;
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      visible: contacts.isNotEmpty,
                      replacement: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(alignment: Alignment.topCenter, child: Text('Cadastre um contato.')),
                      ),
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return Card(
                            child: Column(
                              children: [
                                Text(contact.cpf),
                                Text(contact.name),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  const Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('oi'),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.openCreateContactDialog,
          tooltip: 'Criar contato',
          child: const Icon(Icons.add),
        ),
      );
}
