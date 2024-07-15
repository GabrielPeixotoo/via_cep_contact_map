import '../../entities/entities.dart';

abstract class LoginUsecase {
  Future<void> call({required AuthEntity newLoginUser});
}
