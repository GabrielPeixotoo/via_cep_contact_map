import '../../shared.dart';

class CacheError extends AppError {
  final Map<String, dynamic> payload;

  CacheError({
    super.message = '',
    required super.stackTrace,
    super.error,
    required this.payload,
  });

  factory CacheError.deleteCacheData({
    String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = DeleteCacheError;

  factory CacheError.saveCacheData({
    String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = SaveCacheError;

  factory CacheError.fetchCacheData({
    String message,
    required StackTrace stackTrace,
    Map<String, dynamic> payload,
    Object? error,
  }) = FetchCacheError;
}

class DeleteCacheError extends CacheError {
  DeleteCacheError({
    super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class SaveCacheError extends CacheError {
  SaveCacheError({
    super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}

class FetchCacheError extends CacheError {
  FetchCacheError({
    super.message,
    required super.stackTrace,
    super.payload = const {},
    super.error,
  });
}
