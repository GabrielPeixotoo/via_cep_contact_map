import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/entities/entities.dart';

class AddressModel extends Equatable {
  final String streetName;
  final String state;
  final String city;
  final double latitude;
  final double longitude;
  const AddressModel(
      {required this.streetName,
      required this.state,
      required this.city,
      required this.latitude,
      required this.longitude});

  factory AddressModel.empty() => const AddressModel(city: '', latitude: 0, longitude: 0, state: '', streetName: '');

  factory AddressModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return AddressModel(
        streetName: map['streetName'],
        city: map['city'],
        state: map['state'],
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
        city: addressEntity.city,
        state: addressEntity.state,
        streetName: addressEntity.streetName,
        latitude: addressEntity.latitude,
        longitude: addressEntity.longitude,
      );

  AddressEntity toEntity() => AddressEntity(
        city: city,
        state: state,
        streetName: streetName,
        latitude: latitude,
        longitude: longitude,
      );

  Map<String, dynamic> toMap() => {
        'city': city,
        'state': state,
        'streetName': streetName,
        'latitude': latitude,
        'longitude': longitude,
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [city, state, streetName, latitude, longitude];
}
