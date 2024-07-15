import 'package:via_cep_contacts_projects_uex/modules/home/data/models/coordinate/coordinate_model.dart';

import '../../../../../shared/shared.dart';
import '../../../domain/domain.dart';

class RemoteFetchCoordinates implements FetchCoordinatesUsecase {
  final HttpClient httpClient;
  final String url;
  final String googleApiKey;

  RemoteFetchCoordinates({required this.httpClient, required this.url, required this.googleApiKey});

  @override
  Future<CoordinateEntity> call({required AddressEntity addressEntity}) async {
    try {
      final query = '${addressEntity.streetName}, ${addressEntity.city}, ${addressEntity.state}, ${addressEntity.cep}';
      final response =
          await httpClient.request(url: "$url${'?address=$query&key=$googleApiKey'}", method: HttpMethod.get);
      return (response['results'] as List<dynamic>).map((e) => CoordinateModel.fromMap(map: e)).toList().first;
    } on TypeError catch (e, s) {
      throw ModelError(error: e, stackTrace: s);
    }
  }
}
