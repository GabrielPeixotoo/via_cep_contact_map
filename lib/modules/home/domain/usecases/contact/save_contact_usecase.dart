import '../../entities/entities.dart';

abstract class SaveContactUsecase {
  Future<void> call({required ContactEntity contactEntity});
}
