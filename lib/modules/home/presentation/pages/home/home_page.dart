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
          title: Text(
            'Home ${FlavorConfig.instance.name}',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueListenableBuilder<HomeState>(
                valueListenable: controller,
                builder: (_, state, __) {
                  if (state is InitialState) {
                    return const Text(
                      'Contador não iniciado',
                      style: AppTextTheme.subtitle1,
                    );
                  } else if (state is CounterState) {
                    return Text(
                      'Você clicou no botão\n${state.counter} vezes',
                      textAlign: TextAlign.center,
                      style: AppTextTheme.subtitle1,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
