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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gerenciamento de contatos',
            style: AppTextTheme.subtitle1,
          ),
          centerTitle: true,
          backgroundColor: AppColors.blue,
        ),
        body: Center(
          child: ValueListenableBuilder<HomeState>(
            valueListenable: controller,
            builder: (_, state, __) {
              return const Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('Contatos'),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('oi'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
