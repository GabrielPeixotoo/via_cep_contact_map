import 'package:flutter/material.dart';

import '../../../shared.dart';

abstract class FormNotifier<T> extends ValueNotifier<T> {
  Listenable? _listenable;

  FormNotifier(super.value) {
    _initFormListener();
  }

  List<CustomTextEditingController> get fieldControllers;

  void onFormChanged();

  void _initFormListener() {
    _listenable = Listenable.merge(
      fieldControllers.map((controller) => controller.isValid).toList(),
    );

    _listenable?.addListener(onFormChanged);
  }

  bool get isFormValid => fieldControllers.fold(
        true,
        (previousValue, controller) => previousValue && controller.isValid.value,
      );

  bool get hasUserInteraction => fieldControllers.fold(
        false,
        (previousValue, controller) => previousValue || controller.userInteraction,
      );

  @override
  void dispose() {
    super.dispose();
    for (final controller in fieldControllers) {
      controller.dispose();
    }

    _listenable?.removeListener(onFormChanged);
  }
}
