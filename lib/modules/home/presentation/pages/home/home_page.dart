import 'package:flutter/material.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/domain/domain.dart';

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
                          return ContactCard(
                            contact: contact,
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

class ContactCard extends StatelessWidget {
  final ContactEntity contact;
  const ContactCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _RowLabel(
                      label: 'Nome',
                      content: contact.name,
                    ),
                    _RowLabel(
                      label: 'CPF',
                      content: contact.cpf,
                    ),
                    _RowLabel(
                      label: 'Endereço',
                      content: contact.addressEntity.streetName,
                    ),
                    _RowLabel(
                      label: 'Local',
                      content: '${contact.addressEntity.city}, ${contact.addressEntity.state}',
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on_outlined, size: 50),
                color: AppColors.black,
              )
            ],
          ),
        ),
      );
}

class _RowLabel extends StatelessWidget {
  final String label;
  final String content;
  const _RowLabel({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: AppTextTheme.title2,
        ),
        Text(
          content,
          style: AppTextTheme.title1,
        ),
      ],
    );
  }
}
