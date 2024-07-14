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
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: homeController.logout,
            child: const Text('Sair'))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
