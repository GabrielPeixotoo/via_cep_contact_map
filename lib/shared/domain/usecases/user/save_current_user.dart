import '../../../shared.dart';

abstract class SaveCurrentUserUsecase {
  Future<void> call({required AuthEntity user});
}
