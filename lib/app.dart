import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'shared/shared.dart';

class App extends StatelessWidget {
  App({super.key});

  final _navigatorKey = InjectionContainer.instance<GlobalKey<NavigatorState>>();

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.instance.showInspector) {
      final inspector = InjectionContainer.instance.get<HttpInspector>();
      inspector.setNavigatorKey(_navigatorKey);
    }

    return MaterialApp(
      title: 'Via Cep Contacts Project UEX',
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      theme: AppTheme.defaultThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('pt', 'BR'),
      ],
      initialRoute: AppRoutes.splashPage,
      onGenerateRoute: (settings) {
        final route = AppRoutes.findRoute(name: settings.name ?? '');

        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => route.child(AppRouteArguments(settings.arguments)),
        );
      },
    );
  }
}
