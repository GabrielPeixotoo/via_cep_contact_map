import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String cep;
  final String streetName;
  final String state;
  final String city;
  final double? latitude;
  final double? longitude;

  const AddressEntity({
    required this.cep,
    required this.streetName,
    required this.state,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory AddressEntity.empty() =>
      const AddressEntity(cep: '', city: '', state: '', streetName: '', latitude: null, longitude: null);

  @override
  List<Object?> get props => [cep, streetName, state, city, latitude, longitude];
}
