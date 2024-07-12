import '../../../shared.dart';

abstract class SaveAuthUsecase {
  Future<void> call({required AuthEntity authEntity});
}
