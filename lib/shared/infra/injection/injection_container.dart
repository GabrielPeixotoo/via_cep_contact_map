// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:get_it/get_it.dart';

typedef FactoryFunction<T> = T Function();
typedef DisposingFunction<T> = FutureOr Function(T param);

abstract class InjectionContainer {
  /// Registers a type so that a new instance will be created whenever this type is request from InjectionContainer.
  ///
  /// [T] type to register.<br>
  /// [factory] a function that return an object of the given type
  void registerFactory<T extends Object>(
    FactoryFunction<T> factory,
  );

  /// Registers a Lazy Singleton, i.e. an singleton (unique) instance will be created when this type is first
  /// requested from InjectionContainer, then the same instance will be returned on next requests.
  ///
  /// [T] type to register.<br>
  /// [factory] a function that return an object of the given type
  void registerLazySingleton<T extends Object>(
    FactoryFunction<T> factory, {
    DisposingFunction<T>? dispose,
  });

  /// Gets or creates an instance of type [T] registered on InjectionContainer
  T get<T extends Object>();

  /// Gets or creates an instance of type [T] registered on InjectionContainer
  T call<T extends Object>() => get();

  static final _instance = GetItAdapter(getIt: GetIt.instance);

  /// Gets the singleton instance of InjectionContainer
  static InjectionContainer get instance => _instance;
}

class GetItAdapter extends InjectionContainer {
  final GetIt getIt;

  GetItAdapter({
    required this.getIt,
  });

  @override
  void registerFactory<T extends Object>(FactoryFunction<T> factory) {
    getIt.registerFactory(factory);
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunction<T> factory, {
    DisposingFunction<T>? dispose,
  }) {
    getIt.registerLazySingleton(factory, dispose: dispose);
  }

  @override
  T get<T extends Object>() => getIt.get<T>();
}
