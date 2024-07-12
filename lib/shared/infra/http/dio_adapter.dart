import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../shared.dart';

class DioAdapter extends HttpClient {
  final Dio dio;
  final CheckConnectivity checkConnectivity;
  final HttpInspector httpInspector;
  final CancelToken Function() createToken;

  DioAdapter({
    required this.dio,
    required this.checkConnectivity,
    required this.httpInspector,
    required this.createToken,
  }) {
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
        ),
      );
    }

    if (FlavorConfig.instance.showInspector) {
      dio.interceptors.add(httpInspector.dioInterceptor);
    }

    cancelToken = createToken();
  }

  late CancelToken cancelToken;

  @override
  void cancelRequests() {
    cancelToken.cancel();

    cancelToken = createToken();
  }

  @override
  Future request({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    List<Map<String, dynamic>> files = const [],
    bool sendingMultipleFiles = false,
    Duration? timeout,
    required HttpMethod method,
  }) async {
    try {
      final Map<String, dynamic> dioHeaders = {};
      final formData = await _createFormData(files, sendingMultipleFiles, body);

      dioHeaders
        ..addAll(headers)
        ..addAll({
          'User-Agent': Platform.isAndroid ? 'Android' : 'iPhone',
        });

      final isConnected = await checkConnectivity();

      if (!isConnected) {
        throw ConnectionError();
      }

      final response = await dio
          .request(
            url,
            data: formData ?? body,
            options: Options(headers: dioHeaders, method: method.name.toUpperCase()),
            queryParameters: queryParameters,
            cancelToken: cancelToken,
          )
          .timeout(
            timeout ?? const Duration(seconds: 30),
          );

      return _handleResponse(response);
    } on DioException catch (error, stackTrace) {
      assert(
        !(error.response?.statusCode == 401 && !headers.containsKey('Authorization')),
        'Remember to use AuthClientDecorator!',
      );
      throw _createHttpError(error, stackTrace);
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data ?? {};
    } else if (response.statusCode == 204) {
      return {};
    }
  }

  Future<FormData?> _createFormData(
    List<Map<String, dynamic>> files,
    bool sendingMultipleFiles,
    Map<dynamic, dynamic> body,
  ) async {
    FormData? formData;
    if (files.isNotEmpty) {
      if (files.length == 1 && !sendingMultipleFiles) {
        formData = FormData.fromMap(
          {
            'file': await MultipartFile.fromFile(
              files[0]['path'] as String,
              filename: '${files[0]['fileName']}.${files[0]['subtype']}',
              contentType: MediaType(files[0]['type'], files[0]['subtype']),
            ),
          }..addAll(Map<String, dynamic>.from(body)),
        );
      } else {
        formData = FormData.fromMap(Map<String, dynamic>.from(body));
        for (final file in files) {
          formData.files.add(
            MapEntry(
              'files',
              await MultipartFile.fromFile(
                file['path'] as String,
                filename: '${file['fileName']}.${file['subtype']}',
                contentType: MediaType(file['type'], file['subtype']),
              ),
            ),
          );
        }
      }
    } else if (sendingMultipleFiles) {
      formData = FormData.fromMap(Map<String, dynamic>.from(body));
    }
    return formData;
  }

  HttpError _createHttpError(DioException error, StackTrace stackTrace) {
    final Map<String, dynamic> payload = error.response?.data ?? {};

    final statusCode = error.response?.statusCode;
    final message = error.message ?? '';

    switch (statusCode) {
      case 400:
        return HttpError.badRequest(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 401:
        return HttpError.unauthorized(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 403:
        return HttpError.forbidden(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 404:
        return HttpError.notFound(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 405:
        return HttpError.notAllowed(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 413:
        return HttpError.payloadTooLarge(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 422:
        return HttpError.unprocessableEntity(
          message: message,
          payload: payload,
          stackTrace: stackTrace,
          error: error,
        );
      case 500:
        return HttpError.serverError(
          message: message,
          stackTrace: stackTrace,
          error: error,
          payload: payload,
        );
      default:
        return HttpError.unexpectedError(
          message: message,
          stackTrace: stackTrace,
          error: error,
        );
    }
  }
}
