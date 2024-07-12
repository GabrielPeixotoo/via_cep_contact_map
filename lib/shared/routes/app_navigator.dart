import 'package:flutter/material.dart';

abstract class AppNavigator {
  /// Push a named route on top of current page
  Future<T?> push<T extends Object>(String routeName, {Object? arguments});

  /// Push a named route and clear the stack (delete all previous routes from the stack)
  void pushAndClearStack(String routeName, {Object? arguments});

  /// Pop current page
  void pop<T extends Object>({T? result});

  /// Push a named route and remove current page from stack
  Future<T?> pushReplacement<T extends Object, TO extends Object>(
    String routeName, {
    Object? arguments,
  });

  /// Pop several times, until current route name is [routeName]
  void popUntil({required String routeName});
}

class AppNavigatorImpl implements AppNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  const AppNavigatorImpl({
    required this.navigatorKey,
  });

  @override
  void pushAndClearStack(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  @override
  void pop<T extends Object>({T? result}) {
    navigatorKey.currentState?.pop(result);
  }

  @override
  Future<T?> push<T extends Object>(
    String routeName, {
    Object? arguments,
  }) =>
      navigatorKey.currentState?.pushNamed<T?>(
        routeName,
        arguments: arguments,
      ) ??
      Future.value();

  @override
  Future<T?> pushReplacement<T extends Object, TO extends Object>(
    String routeName, {
    Object? arguments,
  }) =>
      navigatorKey.currentState?.pushReplacementNamed<T?, TO?>(
        routeName,
        arguments: arguments,
      ) ??
      Future.value();

  @override
  void popUntil({required String routeName}) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}
