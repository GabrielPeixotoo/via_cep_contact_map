import '../../shared.dart';

class AuthClientDecorator extends HttpClient {
  final HttpClient client;
  final FetchUsersUsecase fetchAuthUsecase;
  final DeleteUserUsecase deleteAuthUsecase;
  final AppNavigator appNavigator;

  AuthClientDecorator({
    required this.client,
    required this.fetchAuthUsecase,
    required this.deleteAuthUsecase,
    required this.appNavigator,
  });

  @override
  void cancelRequests() {
    client.cancelRequests();
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
      final Map<String, String> authorizedHeaders = {};

      authorizedHeaders.addAll(headers);

      return client.request(
        url: url,
        method: method,
        body: body,
        headers: authorizedHeaders,
        files: files,
        queryParameters: queryParameters,
        sendingMultipleFiles: sendingMultipleFiles,
        timeout: timeout,
      );
    } on UnauthorizedError {
      rethrow;
    }
  }
}
