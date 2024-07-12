import 'dart:async';

import 'shared.dart';

abstract class BaseModule {
  Future<void> init();

  InjectionContainer get instance => InjectionContainer.instance;
}
