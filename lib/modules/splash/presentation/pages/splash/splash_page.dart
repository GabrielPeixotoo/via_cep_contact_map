import 'package:flutter/material.dart';

import '../../../../../shared/shared.dart';
import '../../../splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = InjectionContainer.instance.get<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.goToHome();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
            child: Icon(
          Icons.flutter_dash_outlined,
          size: 200,
        )),
      );
}
