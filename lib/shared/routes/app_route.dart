import 'package:flutter/material.dart';

import '../../modules/home/home.dart';
import '../../modules/splash/splash.dart';
import '../shared.dart';

class AppRoute {
  AppRoute({
    required this.name,
    required this.child,
  });

  final String name;
  final Widget Function(AppRouteArguments args) child;
}

class AppRouteArguments {
  final dynamic data;

  AppRouteArguments(this.data);
}

abstract class AppRoutes {
  static const splashPage = 'splash';
  static const homePage = 'home';

  static InjectionContainer get instance => InjectionContainer.instance;

  static List<AppRoute> get routesList => [
        AppRoute(
          name: splashPage,
          child: (_) => const SplashPage(),
        ),
        AppRoute(
          name: homePage,
          child: (_) => const HomePage(),
        ),
      ];

  static AppRoute findRoute({required String name}) => routesList.firstWhere(
        (element) => name == element.name,
        orElse: () => throw Exception(
          "The route $name isn't registered on AppRoutes.",
        ),
      );
}
