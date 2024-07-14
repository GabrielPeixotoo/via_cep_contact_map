import 'package:equatable/equatable.dart';

import '../entities.dart';

class ContactEntity extends Equatable {
  final String cpf;
  final String name;
  final String phone;
  final AddressEntity addressEntity;

  const ContactEntity({required this.cpf, required this.name, required this.phone, required this.addressEntity});

  String get completeAddress => '${addressEntity.streetName}, ${addressEntity.city} - ${addressEntity.state}';

  @override
  List<Object?> get props => [cpf, name, addressEntity, phone];
}
