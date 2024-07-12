import 'package:chuck_interceptor/chuck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../shared.dart';

class ChuckAdapter implements HttpInspector {
  final _chuck = Chuck(showInspectorOnShake: true);

  @override
  Interceptor get dioInterceptor => _chuck.getDioInterceptor();

  @override
  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _chuck.setNavigatorKey(navigatorKey);
  }
}
