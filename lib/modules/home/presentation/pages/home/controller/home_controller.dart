import 'package:flutter/material.dart';

import 'home_state.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(HomeState.initial());

  void increment() {
    final state = value;

    if (state is InitialState) {
      value = HomeState.counter(counter: 1);
    } else if (state is CounterState) {
      value = HomeState.counter(counter: state.counter + 1);
    }
  }

  void decrement() {
    value = HomeState.counter(counter: (value as CounterState).counter - 1);
  }
}
