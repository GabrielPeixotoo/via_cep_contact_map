import '../../domain.dart';

abstract class FetchAddressByCepUsecase {
  Future<List<AddressEntity>> call({required String cep});
}
