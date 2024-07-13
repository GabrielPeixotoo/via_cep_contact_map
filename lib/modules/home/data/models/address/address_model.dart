import 'dart:convert';

import '../../../../../shared/shared.dart';
import '../../../domain/entities/entities.dart';
import '../../../shared.dart';

class AddressModel extends AddressEntity {
  const AddressModel(
      {required super.streetName,
      required super.city,
      required super.state,
      required super.latitude,
      asdf
      asdf
      as
      asd
      f
      required super.longitude});

  factory AddressModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AddressModel(
        streetName: map['streetName'],
        city: map['city']
        state:  map['state']
        latitude:  map['latitude']
        longitude: map['longitude']
      );
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AddressModel.fromJson({required String json}) {
    try {
      return json.isEmpty ? const AddressModel(password: '', email: '') : AddressModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AddressModel.fromEntity({required AuthEntity authEntity}) =>
      AddressModel(password: authEntity.password, email: authEntity.email);

  AuthEntity toEntity() => AuthEntity(password: password, email: email);

  Map<String, dynamic> toMap() => {'email': email, 'password': password};

  String toJson() => jsonEncode(toMap());
}
