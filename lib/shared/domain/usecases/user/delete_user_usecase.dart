import '../../domain.dart';

abstract class DeleteUserUsecase {
  Future<void> call({required AuthEntity user});
}
