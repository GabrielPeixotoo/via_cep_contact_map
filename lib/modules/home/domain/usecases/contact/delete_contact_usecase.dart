import '../../entities/entities.dart';

abstract class DeleteContactUsecase {
  Future<void> call({required ContactEntity contactEntity});
}
