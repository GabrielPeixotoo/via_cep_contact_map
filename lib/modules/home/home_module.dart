import '../../shared/shared.dart';
import 'data/usecases/usecases.dart';
import 'domain/domain.dart';
import 'home.dart';

class HomeModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<FetchContactsUsecase>(() => LocalFetchContacts(
          fetchCurrentUserUsecase: instance(),
          localStorage: instance(),
        ));
    instance.registerFactory<SaveContactUsecase>(() => LocalSaveContact(
          fetchContactsUsecase: instance(),
          fetchCurrentUserUsecase: instance(),
          localStorage: instance(),
        ));

    instance.registerFactory<FetchAddressByCepUsecase>(
        () => RemoteFetchAddressByCep(httpClient: instance(), url: makeViaCepUrl()));
    instance.registerFactory<FetchCepByAddressUsecase>(
        () => RemoteFetchCepByAddress(httpClient: instance(), url: makeViaCepUrl()));
    instance.registerFactory<FetchCoordinatesUsecase>(() => RemoteFetchCoordinates(
          httpClient: instance(),
          url: 'https://maps.googleapis.com/maps/api/geocode/json',
          googleApiKey: makeGoogleApiKey(),
        ));

    instance.registerFactory<EditContactUsecase>(() => LocalEditContact(
          fetchContactsUsecase: instance(),
          localStorage: instance(),
          fetchCurrentUserUsecase: instance(),
        ));
    instance.registerFactory<ContactFormController>(() => ContactFormController(
          uiHelper: instance(),
          appNavigator: instance(),
          saveContactUsecase: instance(),
          fetchAddressByCepUsecase: instance(),
          fetchCepByAddressUsecase: instance(),
          fetchCoordinatesUsecase: instance(),
          editContactUsecase: instance(),
        ));
    instance.registerFactory<DeleteAllContactsUsecase>(() => LocalDeleteAllContacts(
          fetchCurrentUserUsecase: instance(),
          localStorage: instance(),
        ));

    instance.registerFactory<DeleteContactUsecase>(() => LocalDeleteContact(
          fetchContactsUsecase: instance(),
          localStorage: instance(),
          fetchCurrentUserUsecase: instance(),
        ));

    instance.registerFactory<DeleteUserUsecase>(
      () => LocalDeleteUser(
        localStorage: instance(),
        fetchCurrentUserUsecase: instance(),
        fetchUsersUsecase: instance(),
      ),
    );

    instance.registerFactory<HomeController>(() => HomeController(
          uiHelper: instance(),
          deleteAllContactsUsecase: instance(),
          deleteContactUsecase: instance(),
          fetchContactsUsecase: instance(),
          appNavigator: instance(),
          deleteCurrentUserUsecase: instance(),
          fetchCurrentUserUsecase: instance(),
        ));

    instance.registerFactory<DeleteAccountController>(() => DeleteAccountController(
        uiHelper: instance(),
        deleteAllContactsUsecase: instance(),
        appNavigator: instance(),
        deleteCurrentUserUsecase: instance(),
        fetchCurrentUserUsecase: instance(),
        deleteUserUsecase: instance()));
  }
}
