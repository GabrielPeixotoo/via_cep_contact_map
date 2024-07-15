import '../../../shared.dart';

abstract class FetchUsersUsecase {
  Future<List<AuthEntity>> call();
}
