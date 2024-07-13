import '../../../shared.dart';

abstract class FetchAuthUsecase {
  Future<AuthEntity?> call({required String username});
}
