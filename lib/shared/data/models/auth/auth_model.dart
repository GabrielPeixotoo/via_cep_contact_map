import 'dart:convert';

import '../../../shared.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.email, required super.password});

  factory AuthModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AuthModel(email: map['email'], password: map['password']);
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromJson({required String json}) {
    try {
      return json.isEmpty ? const AuthModel(password: '', email: '') : AuthModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AuthModel.fromEntity({required AuthEntity authEntity}) =>
      AuthModel(password: authEntity.password, email: authEntity.email);

  Map<String, dynamic> toMap() => {'email': email, 'password': password};

  String toJson() => jsonEncode(toMap());
}
