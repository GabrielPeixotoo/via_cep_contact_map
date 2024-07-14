import 'package:flutter/material.dart';

import '../../../../../../shared/shared.dart';
import '../components/dialogs/contact_form/contact_form_dialog.dart';
import 'home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  final UIHelper uiHelper;
  HomeController({
    required this.uiHelper,
  }) : super(HomeState.initial());

  void increment() {
    uiHelper.showCustomDialog(dialog: const ContactFormDialog());
  }

  void decrement() {
    value = HomeState.counter(counter: (value as CounterState).counter - 1);
  }
}
