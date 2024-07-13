import '../../../shared.dart';

abstract class FetchCurrentUserUsecase {
  Future<AuthEntity?> call();
}
