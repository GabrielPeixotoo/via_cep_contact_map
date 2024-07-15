import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/data/models/models.dart';
import 'package:via_cep_contacts_projects_uex/modules/home/domain/domain.dart';

void main() {
  late Map<String, dynamic> addressMap;
  late AddressModel addressModel;
  late AddressEntity addressEntity;

  setUp(() {
    addressMap = {
      'cep': '12345-678',
      'city': 'City',
      'state': 'State',
      'streetName': 'Main Street',
      'latitude': 37.7749,
      'longitude': -122.4194,
      'complement': 'Apartment 101',
    };

    addressModel = const AddressModel(
      cep: '12345-678',
      streetName: 'Main Street',
      state: 'State',
      city: 'City',
      complement: 'Apartment 101',
      latitude: 37.7749,
      longitude: -122.4194,
    );

    addressEntity = const AddressEntity(
      cep: '12345-678',
      streetName: 'Main Street',
      state: 'State',
      city: 'City',
      complement: 'Apartment 101',
      latitude: 37.7749,
      longitude: -122.4194,
    );
  });

  group('AddressModel', () {
    test('fromMap should create an AddressModel from a map', () {
      final result = AddressModel.fromMap(map: addressMap);

      expect(result, addressModel);
    });

    test('fromJson should create an AddressModel from a JSON string', () {
      final json = jsonEncode(addressMap);

      final result = AddressModel.fromJson(json: json);

      expect(result, addressModel);
    });

    test('fromEntity should create an AddressModel from an AddressEntity', () {
      final result = AddressModel.fromEntity(addressEntity: addressEntity);

      expect(result, addressModel);
    });

    test('toEntity should convert AddressModel to AddressEntity', () {
      final entity = addressModel.toEntity();

      expect(entity, addressEntity);
    });

    test('toMap should convert AddressModel to a map', () {
      final result = addressModel.toMap();

      expect(result, addressMap);
    });

    test('toJson should convert AddressModel to a JSON string', () {
      final json = jsonEncode(addressMap);

      final result = addressModel.toJson();

      expect(result, json);
    });

    test('empty should create an AddressModel with empty fields', () {
      final result = AddressModel.empty();

      expect(
          result,
          const AddressModel(
            cep: '',
            city: '',
            complement: '',
            latitude: 0,
            longitude: 0,
            state: '',
            streetName: '',
          ));
    });
  });
}
