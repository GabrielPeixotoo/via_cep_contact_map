import '../../entities/entities.dart';

abstract class EditContactUsecase {
  Future<void> call({required ContactEntity contactEntity});
}
