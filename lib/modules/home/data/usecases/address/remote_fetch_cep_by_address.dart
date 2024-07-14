import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';
import '../../models/models.dart';

class RemoteFetchCepByAddress implements FetchCepByAddressUsecase {
  final HttpClient httpClient;
  final String url;

  RemoteFetchCepByAddress({required this.httpClient, required this.url});

  @override
  Future<List<AddressEntity>> call({required FetchCepByAddressParams params}) async {
    try {
      final remoteParams = RemoteFetchCepByAddressUsecaseParams.fromDomain(params);
      final encodedStreetName = Uri.encodeComponent(remoteParams.streetName);
      final response = await httpClient.request(
          url: '$url/${remoteParams.state}/${remoteParams.city}/$encodedStreetName/json/', method: HttpMethod.get);
      return (response as List<dynamic>).map((e) => BrazilianAddressModel.fromMap(map: e).toEntity()).toList();
    } on TypeError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}

class RemoteFetchCepByAddressUsecaseParams extends FetchCepByAddressParams {
  const RemoteFetchCepByAddressUsecaseParams({
    required super.city,
    required super.state,
    required super.streetName,
  });

  factory RemoteFetchCepByAddressUsecaseParams.fromDomain(FetchCepByAddressParams params) =>
      RemoteFetchCepByAddressUsecaseParams(
        city: params.city,
        state: params.state,
        streetName: params.streetName,
      );
}
