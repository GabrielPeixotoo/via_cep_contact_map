import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../models.dart';

class ContactModel extends Equatable {
  final String cpf;
  final String phone;
  final String name;
  final AddressModel addressModel;

  const ContactModel({required this.cpf, required this.name, required this.phone, required this.addressModel});

  factory ContactModel.empty() => ContactModel(phone: '', cpf: '', name: '', addressModel: AddressModel.empty());

  factory ContactModel.fromMap({required Map<String, dynamic> map}) {
    try {
      return ContactModel(
        addressModel: AddressModel.fromMap(map: map['address']),
        cpf: map['cpf'],
        name: map['name'],
        phone: map['phone'] ?? '',
      );
    } on TypeError catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory ContactModel.fromJson({required String json}) {
    try {
      return json.isEmpty ? ContactModel.empty() : ContactModel.fromMap(map: jsonDecode(json));
    } on FormatException catch (error, stackTrace) {
      throw ModelError(error: error, stackTrace: stackTrace);
    }
  }

  factory ContactModel.fromEntity({required ContactEntity contactEntity}) => ContactModel(
        cpf: contactEntity.cpf,
        name: contactEntity.name,
        phone: contactEntity.phone,
        addressModel: AddressModel.fromEntity(addressEntity: contactEntity.addressEntity),
      );

  ContactEntity toEntity() => ContactEntity(phone: phone, cpf: cpf, name: name, addressEntity: addressModel.toEntity());

  Map<String, dynamic> toMap() => {
        'cpf': cpf,
        'name': name,
        'phone': phone,
        'address': addressModel.toMap(),
      };

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [cpf, name, addressModel];
}
