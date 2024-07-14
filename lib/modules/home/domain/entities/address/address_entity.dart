import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String cep;
  final String streetName;
  final String state;
  final String city;
  final String complement;
  final double? latitude;
  final double? longitude;

  const AddressEntity({
    required this.cep,
    required this.streetName,
    required this.state,
    required this.city,
    required this.complement,
    required this.latitude,
    required this.longitude,
  });

  factory AddressEntity.empty() => const AddressEntity(
      complement: '', cep: '', city: '', state: '', streetName: '', latitude: null, longitude: null);

  @override
  List<Object?> get props => [
        cep,
        streetName,
        state,
        city,
        latitude,
        longitude,
        complement,
      ];

  AddressEntity copyWith({
    String? cep,
    String? streetName,
    String? state,
    String? city,
    String? complement,
    double? latitude,
    double? longitude,
  }) {
    return AddressEntity(
      cep: cep ?? this.cep,
      streetName: streetName ?? this.streetName,
      state: state ?? this.state,
      city: city ?? this.city,
      complement: complement ?? this.complement,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
