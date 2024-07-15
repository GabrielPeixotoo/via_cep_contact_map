import '../../../shared.dart';

abstract class SaveUserUsecase {
  Future<void> call({required AuthEntity authEntity});
}
