import '../../../shared.dart';

abstract class FetchUserUsecase {
  Future<AuthEntity?> call({required String username});
}
