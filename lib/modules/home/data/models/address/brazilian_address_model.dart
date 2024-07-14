import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

class BrazilianAddressModel extends Equatable {
  final String cep;
  final String streetName;
  final String state;
  final String city;
  final String complement;

  const BrazilianAddressModel(
      {required this.cep, required this.city, required this.streetName, required this.state, required this.complement});

  factory BrazilianAddressModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return BrazilianAddressModel(
        cep: map['cep'].toString().replaceAll('-', ''),
        streetName: map['logradouro'],
        complement: map['complemento'],
        state: map['uf'],
        city: map['localidade'],
      );
    } on HttpError catch (_) {
      rethrow;
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  AddressEntity toEntity() => AddressEntity(
        cep: cep,
        streetName: streetName,
        state: state,
        city: city,
        complement: complement,
        latitude: null,
        longitude: null,
      );

  @override
  List<Object?> get props => [
        cep,
        streetName,
        state,
        city,
      ];
}
