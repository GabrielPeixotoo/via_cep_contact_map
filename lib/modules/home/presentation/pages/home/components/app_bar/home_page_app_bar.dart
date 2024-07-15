import 'package:flutter/material.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/home.dart';

import '../../../../../../../shared/shared.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeController homeController;
  const HomePageAppBar({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FutureBuilder<String>(
          future: homeController.fetchCurrentUsername(),
          builder: (context, snapshot) {
            final email = snapshot.data ?? '';
            return Text(
              'Seja bem-vindo, $email',
              style: AppTextTheme.subtitle1,
            );
          }),
      centerTitle: true,
      backgroundColor: AppColors.blue,
      actions: [
        CustomContextMenu(
          items: const ['Sair', 'Apagar conta e dados'],
          onSelected: (value) => switch (value) {
            0 => homeController.logout(),
            1 => homeController.showDeleteAccountDialog(),
            _ => null,
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
