import '../../domain.dart';

abstract class FetchAddressByCepUsecase {
  Future<AddressEntity> call({required String cep});
}
