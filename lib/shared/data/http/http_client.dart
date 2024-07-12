enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
}

abstract class HttpClient {
  void cancelRequests();

  Future request({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    List<Map<String, dynamic>> files = const [],
    bool sendingMultipleFiles = false,
    Duration? timeout,
    required HttpMethod method,
  });

  Future<dynamic> get({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Duration? timeout,
  }) =>
      request(
        url: url,
        method: HttpMethod.get,
        headers: headers,
        queryParameters: queryParameters,
        timeout: timeout,
      );

  Future<dynamic> post({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    List<Map<String, dynamic>> files = const [],
    bool sendingMultipleFiles = false,
    Duration? timeout,
  }) =>
      request(
        url: url,
        method: HttpMethod.post,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
        timeout: timeout,
        files: files,
        sendingMultipleFiles: sendingMultipleFiles,
      );

  Future<dynamic> put({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    List<Map<String, dynamic>> files = const [],
    bool sendingMultipleFiles = false,
    Duration? timeout,
  }) =>
      request(
        url: url,
        method: HttpMethod.put,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
        timeout: timeout,
        files: files,
        sendingMultipleFiles: sendingMultipleFiles,
      );

  Future<dynamic> patch({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    List<Map<String, dynamic>> files = const [],
    bool sendingMultipleFiles = false,
    Duration? timeout,
  }) =>
      request(
        url: url,
        method: HttpMethod.patch,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
        timeout: timeout,
        files: files,
        sendingMultipleFiles: sendingMultipleFiles,
      );

  Future<dynamic> delete({
    required String url,
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map body = const {},
    Duration? timeout,
  }) =>
      request(
        url: url,
        method: HttpMethod.delete,
        body: body,
        headers: headers,
        queryParameters: queryParameters,
        timeout: timeout,
      );
}
