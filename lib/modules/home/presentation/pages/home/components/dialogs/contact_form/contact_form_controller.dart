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
  ContactFormController({
    required this.saveContactUsecase,
    required this.uiHelper,
    required this.appNavigator,
    required this.fetchAddressByCepUsecase,
    required this.fetchCepByAddressUsecase,
  }) : super(ContactFormState.initial());

  final nameTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final cpfTextController = CustomTextEditingController(validator: ValidatorBuilder().cpf().build().call);
  final phoneTextController =
      CustomTextEditingController(validator: ValidatorBuilder().required().phone().build().call);
  final cityTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final cepTextController = CustomTextEditingController(validator: ValidatorBuilder().required().cep().build().call);
  final addressTextController = CustomTextEditingController(validator: ValidatorBuilder().required().build().call);
  final complementTextController = CustomTextEditingController();

  final stateNotifier = ValueNotifier<String>('');

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
      value = ContactFormState.initial();
    }
  }

  void onChangedState(String value) {
    stateNotifier.value = value;
  }

  Future<void> onChangedAddress() async {
    if (addressTextController.text.length >= 3 &&
        cityTextController.text.isNotEmpty &&
        stateNotifier.value.isNotEmpty) {
      final params = FetchCepByAddressParams(
        streetName: addressTextController.text,
        city: cityTextController.text,
        state: stateNotifier.value,
      );
      final addresses = await fetchCepByAddressUsecase.call(params: params);
    }
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

  Future<void> addContact() async {
    try {
      value = ContactFormState.loading();
      final contact = ContactEntity(
          cpf: cpfTextController.text,
          name: nameTextController.text,
          addressEntity: const AddressEntity(
            cep: '',
            city: '',
            latitude: -25,
            longitude: -25,
            state: '',
            streetName: '',
            complement: '',
          ));
      await saveContactUsecase(contactEntity: contact);

      value = ContactFormState.validated();
      appNavigator.pushReplacement(AppRoutes.homePage);
    } on ConnectionError {
      value = ContactFormState.validated();
    } catch (error) {
      if (error is UserNotFound) {
        uiHelper.showCustomSnackBar(
            snackBar: makeSnackBar(icon: Icons.error, text: 'Usuário não encontrado!', backgroundColor: Colors.red));
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
