import 'package:via_cep_contacts_projects_uex/modules/home/domain/domain.dart';

abstract class FetchCoordinatesUsecase {
  Future<CoordinateEntity> call({required AddressEntity addressEntity});
}
