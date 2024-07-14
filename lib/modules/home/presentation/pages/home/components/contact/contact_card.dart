import 'package:flutter/material.dart';

import '../../../../../../../shared/shared.dart';
import '../../../../../domain/domain.dart';

class ContactCard extends StatelessWidget {
  final VoidCallback markerCallback;
  final ContactEntity contact;
  const ContactCard({
    super.key,
    required this.contact,
    required this.markerCallback,
  });

  @override
  Widget build(BuildContext context) => Card(
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
              Flexible(
                child: IconButton(
                  onPressed: markerCallback,
                  icon: const Icon(Icons.location_on_outlined, size: 50),
                  color: AppColors.black,
                ),
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
              style: AppTextTheme.title1,
            ),
          ],
        ),
      ),
    );
  }
}
