abstract class HomeState {
  factory HomeState.initial() = InitialState;
  factory HomeState.counter({required int counter}) = CounterState;
}

class InitialState implements HomeState {
  InitialState();
}

class CounterState implements HomeState {
  final int counter;
  CounterState({
    required this.counter,
  });
}
