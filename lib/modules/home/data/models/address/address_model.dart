import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/entities/entities.dart';

class AddressModel extends Equatable {
  final String cep;
  final String complement;
  final String streetName;
  final String state;
  final String city;
  final double? latitude;
  final double? longitude;
  const AddressModel(
      {required this.cep,
      required this.streetName,
      required this.state,
      required this.city,
      required this.complement,
      required this.latitude,
      required this.longitude});

  factory AddressModel.empty() =>
      const AddressModel(cep: '', city: '', complement: '', latitude: 0, longitude: 0, state: '', streetName: '');

  factory AddressModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AddressModel(
        cep: map['cep'],
        streetName: map['streetName'],
        city: map['city'],
        state: map['state'],
        complement: map['complement'],
        latitude: map['latitude'],
        longitude: map['longitude'],
      );
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AddressModel.fromJson({required String json}) {
    try {
      return json.isEmpty ? AddressModel.empty() : AddressModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory AddressModel.fromEntity({required AddressEntity addressEntity}) => AddressModel(
        cep: addressEntity.cep,
        city: addressEntity.city,
        state: addressEntity.state,
        streetName: addressEntity.streetName,
        latitude: addressEntity.latitude,
        longitude: addressEntity.longitude,
        complement: addressEntity.complement,
      );

  AddressEntity toEntity() => AddressEntity(
        cep: cep,
        city: city,
        state: state,
        streetName: streetName,
        latitude: latitude,
        longitude: longitude,
        complement: complement,
      );

  Map<String, dynamic> toMap() => {
        'city': city,
        'state': state,
        'streetName': streetName,
        'latitude': latitude,
        'longitude': longitude,
        'complement': complement,
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [city, state, streetName, latitude, longitude];
}
