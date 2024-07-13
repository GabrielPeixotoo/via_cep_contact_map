import 'dart:convert';

import '../../../shared.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.username, required super.password});

  factory AuthModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AuthModel(username: map['username'], password: map['password']);
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromJson({required String json}) {
    try {
      return json.isEmpty ? const AuthModel(password: '', username: '') : AuthModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromEntity({required AuthEntity authEntity}) =>
      AuthModel(password: authEntity.password, username: authEntity.username);

  Map<String, dynamic> toMap() => {'username': username, 'password': password};

  String toJson() => jsonEncode(toMap());
}
