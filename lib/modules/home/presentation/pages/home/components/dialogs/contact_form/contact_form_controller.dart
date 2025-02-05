import 'package:flutter/material.dart';

import '../../../../../../../../shared/shared.dart';
import '../../../../../../domain/domain.dart';
import '../../../home.dart';

class ContactFormController extends FormNotifier<ContactFormState> {
  final SaveContactUsecase saveContactUsecase;
  final UIHelper uiHelper;
  final AppNavigator appNavigator;
  final FetchAddressByCepUsecase fetchAddressByCepUsecase;
  final FetchCepByAddressUsecase fetchCepByAddressUsecase;
  final FetchCoordinatesUsecase fetchCoordinatesUsecase;
  final EditContactUsecase editContactUsecase;
  ContactFormController({
    required this.saveContactUsecase,
    required this.uiHelper,
    required this.appNavigator,
    required this.fetchAddressByCepUsecase,
    required this.fetchCepByAddressUsecase,
    required this.fetchCoordinatesUsecase,
    required this.editContactUsecase,
  }) : super(ContactFormState.initial(suggestedCeps: []));

  final nameTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final cpfTextController = CustomTextEditingController(validator: ValidatorBuilder().cpf().build().call);
  final phoneTextController =
      CustomTextEditingController(validator: ValidatorBuilder().required().phone().build().call);
  final cityTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final cepTextController = CustomTextEditingController(validator: ValidatorBuilder().required().cep().build().call);
  final addressTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final complementTextController = CustomTextEditingController();

  final stateNotifier = ValueNotifier<String?>(null);

  @override
  List<CustomTextEditingController> get fieldControllers => [
        nameTextController,
        cpfTextController,
        phoneTextController,
        cityTextController,
        cepTextController,
        addressTextController,
      ];

  @override
  void onFormChanged() {
    if (isFormValid) {
      value = ContactFormState.validated();
    } else {
      value = ContactFormState.initial(suggestedCeps: []);
    }
  }

  void onChangedState(String value) {
    stateNotifier.value = value;
    onChangedAddress();
  }

  Future<void> onChangedAddress() async {
    final state = value;
    final ufValue = stateNotifier.value;
    if (addressTextController.text.length >= 3 && cityTextController.text.isNotEmpty && ufValue != null) {
      final params = FetchCepByAddressParams(
        streetName: addressTextController.text,
        city: cityTextController.text,
        state: ufValue,
      );
      final addresses = await fetchCepByAddressUsecase.call(params: params);

      if (state is ContactFormInitialState) {
        value = state.copyWith(
          suggestedCeps: addresses.map((e) => e.cep).toList(),
        );
      }
    }
  }

  void onTapCep(String cep) {
    cepTextController.text = cep;
    cepTextController.validate(cep);
    onChangedCep();
  }

  Future<void> onChangedCep() async {
    if (cepTextController.text.length == 8) {
      final address = await fetchAddressByCepUsecase.call(cep: cepTextController.text);
      _validateFields(address);
    }
  }

  void _validateFields(AddressEntity address) {
    stateNotifier.value = address.state;
    addressTextController.text = address.streetName;
    addressTextController.validate(address.streetName);
    cityTextController.text = address.city;
    cityTextController.validate(address.city);
    complementTextController.text = address.complement;
    complementTextController.validate(address.complement);
  }

  Future<void> addContact({ContactEntity? contactEntity}) async {
    try {
      value = ContactFormState.loading();
      final address = AddressEntity(
        cep: cepTextController.text,
        city: cityTextController.text,
        state: stateNotifier.value ?? '',
        streetName: addressTextController.text,
        complement: complementTextController.text,
        latitude: null,
        longitude: null,
      );
      final coordinates = await fetchCoordinatesUsecase(addressEntity: address);
      final contact = ContactEntity(
        cpf: cpfTextController.text,
        name: nameTextController.text,
        phone: phoneTextController.text,
        addressEntity: address.copyWith(latitude: coordinates.lat, longitude: coordinates.long),
      );
      if (contactEntity == null) {
        await saveContactUsecase(contactEntity: contact);
      } else {
        await editContactUsecase(contactEntity: contact);
      }

      value = ContactFormState.validated();
      appNavigator.pop(result: true);
    } on ConnectionError {
      value = ContactFormState.validated();
    } catch (error) {
      if (error is DuplicatedContact) {
        cpfTextController.errorText.value = 'CPF já existente na base de dados';
        value = ContactFormState.validated();
      } else {
        value = ContactFormState.validated();
      }
    }
  }

  Future<void> goToSignUpPage() async {
    appNavigator.pushReplacement(AppRoutes.signUpPage);
  }
}
