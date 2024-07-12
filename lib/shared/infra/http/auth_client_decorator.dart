import '../../shared.dart';

class AuthClientDecorator extends HttpClient {
  final HttpClient client;
  final FetchAuthUsecase fetchAuthUsecase;
  final DeleteAuthUsecase deleteAuthUsecase;
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

      final auth = await fetchAuthUsecase();

      authorizedHeaders.addAll(headers);

      if (auth.token.isNotEmpty) {
        authorizedHeaders.addAll({'Authorization': auth.token});
      }

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
      await deleteAuthUsecase();
      appNavigator.pushAndClearStack(AppRoutes.homePage);
      rethrow;
    }
  }
}
