import '../../shared/shared.dart';
import 'data/usecases/usecases.dart';
import 'domain/domain.dart';
import 'home.dart';

class HomeModule extends BaseModule {
  @override
  Future<void> init() async {
    instance.registerFactory<HomeController>(() => HomeController(uiHelper: instance()));
    instance.registerFactory<FetchContactsUsecase>(() => LocalFetchContacts(
          fetchCurrentUserUsecase: instance(),
          localStorage: instance(),
        ));
    instance.registerFactory<SaveContactUsecase>(() => LocalSaveContact(
          fetchContactsUsecase: instance(),
          fetchCurrentUserUsecase: instance(),
          localStorage: instance(),
        ));

    const viaCepUrl = "https://viacep.com.br/ws";
    instance.registerFactory<FetchAddressByCepUsecase>(
        () => RemoteFetchAddressByCep(httpClient: instance(), url: viaCepUrl));
    instance.registerFactory<FetchCepByAddressUsecase>(
        () => RemoteFetchCepByAddress(httpClient: instance(), url: viaCepUrl));
    instance.registerFactory<ContactFormController>(() => ContactFormController(
          uiHelper: instance(),
          appNavigator: instance(),
          saveContactUsecase: instance(),
          fetchAddressByCepUsecase: instance(),
          fetchCepByAddressUsecase: instance(),
        ));
  }
}
