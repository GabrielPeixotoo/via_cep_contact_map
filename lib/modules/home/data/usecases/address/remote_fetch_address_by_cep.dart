import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../models/models.dart';

class RemoteFetchAddressByCep implements FetchAddressByCepUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteFetchAddressByCep({required this.httpClient, required this.url});

  @override
  Future<List<AddressEntity>> call({required String cep}) async {
    try {
      final response = await httpClient.request(url: '$url/$cep/json/', method: HttpMethod.get);
      return [BrazilianAddressModel.fromMap(map: response).toEntity()];
    } on TypeError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
