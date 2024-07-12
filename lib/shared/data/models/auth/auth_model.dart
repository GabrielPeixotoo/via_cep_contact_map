import 'dart:convert';

import '../../../shared.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.token});

  factory AuthModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AuthModel(token: map['token']);
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromJson({required String json}) {
    try {
      return json.isEmpty
          ? const AuthModel(token: '')
          : AuthModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromEntity({required AuthEntity authEntity}) =>
      AuthModel(token: authEntity.token);

  Map<String, dynamic> toMap() => {'token': token};

  String toJson() => jsonEncode(toMap());
}
