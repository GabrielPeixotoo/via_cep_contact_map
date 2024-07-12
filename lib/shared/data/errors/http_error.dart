import '../../shared.dart';

abstract class HttpError extends AppError {
  final Map<String, dynamic> payload;

  HttpError({
    required super.message,
    required super.stackTrace,
    super.error,
    required this.payload,
  });

  factory HttpError.badRequest({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = BadRequestError;

  factory HttpError.unauthorized({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = UnauthorizedError;

  factory HttpError.forbidden({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = ForbiddenError;

  factory HttpError.notFound({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = NotFoundError;

  factory HttpError.notAllowed({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = NotAllowedError;

  factory HttpError.payloadTooLarge({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = PayloadTooLargeError;

  factory HttpError.unprocessableEntity({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = UnprocessableEntityError;

  factory HttpError.serverError({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = ServerError;

  factory HttpError.unexpectedError({
    required String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = UnexpectedError;
}

class BadRequestError extends HttpError {
  BadRequestError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class UnauthorizedError extends HttpError {
  UnauthorizedError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class ForbiddenError extends HttpError {
  ForbiddenError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class NotFoundError extends HttpError {
  NotFoundError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class NotAllowedError extends HttpError {
  NotAllowedError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class PayloadTooLargeError extends HttpError {
  PayloadTooLargeError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class UnprocessableEntityError extends HttpError {
  UnprocessableEntityError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class ServerError extends HttpError {
  ServerError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class UnexpectedError extends HttpError {
  UnexpectedError({
    required super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}
