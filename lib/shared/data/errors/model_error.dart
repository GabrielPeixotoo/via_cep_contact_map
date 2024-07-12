import '../../shared.dart';

class ModelError extends AppError {
  ModelError({
    super.message = '',
    super.stackTrace,
    super.error,
  });
}
