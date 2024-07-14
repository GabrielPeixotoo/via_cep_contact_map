import '../../shared.dart';

class ModelError extends AppError {
  ModelError({
    super.message = '',
    super.stackTrace,
    super.error,
  });
}

class UserAlreadyExists extends ModelError {}

class DuplicatedContact extends ModelError {}

class UserNotFound extends ModelError {}
