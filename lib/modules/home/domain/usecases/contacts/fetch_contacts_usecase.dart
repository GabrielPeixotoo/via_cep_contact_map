import '../../entities/entities.dart';

abstract class FetchContactsUsecase {
  Future<List<ContactEntity>> call();
}
