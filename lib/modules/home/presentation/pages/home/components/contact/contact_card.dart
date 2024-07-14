import 'package:flutter/material.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/home.dart';

import '../../../../../../../shared/shared.dart';
import '../../../../../domain/domain.dart';

class ContactCard extends StatelessWidget {
  final HomeController homeController;
  final VoidCallback markerCallback;
  final ContactEntity contact;
  const ContactCard({
    super.key,
    required this.contact,
    required this.homeController,
    required this.markerCallback,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: markerCallback,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        label: 'Telefone',
                        content: contact.phone,
                      ),
                      _RowLabel(
                        label: 'Endereço',
                        content: contact.completeAddress,
                      ),
                      _RowLabel(
                        label: 'CEP',
                        content: contact.addressEntity.cep,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: homeController.editContact,
                      icon: const Icon(Icons.edit, size: 50),
                      color: AppColors.black,
                    ),
                    IconButton(
                      onPressed: markerCallback,
                      icon: const Icon(Icons.delete_forever, size: 50),
                      color: AppColors.red,
                    ),
                  ],
                )
              ],
            ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: AppTextTheme.title2.copyWith(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: content,
              style: AppTextTheme.title2,
            ),
          ],
        ),
      ),
    );
  }
}
