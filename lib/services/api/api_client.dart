import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// [ApiClient] is the custom implementation for calling HTTP services.
/// The client used is [Dio], a powerful HTTP client.
/// In the constructor, [Interceptor]s are added to the client in order to
/// generate logs and if needed handle the navigation based on error received.

class ApiClient {
  final Map<String, String> headers = {};
  final String basePath;
  final Dio dio = Dio();

  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';

  ApiClient({
    required this.basePath,
  }) {
    _initInterceptors();
  }

  Future<T> makeGet<T>(
      String endPath, {
        String? token,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
        required T Function(dynamic) converter,
      }) async {

    return _makeRequest(endPath, get,
        converter: converter,
        token: token,
        queryParameters: queryParameters,
        cancelToken: cancelToken
    );
  }

  Future<T> makePost<T>(
      String endPath, {
        String? token,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        required T Function(dynamic) converter,
      }) async {

    return _makeRequest(endPath, post,
        converter: converter,
        token: token,
        queryParameters: queryParameters,
        body: body,
        cancelToken: cancelToken
    );
  }

  Future<T> makePut<T>(
      String endPath, {
        String? token,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        required T Function(dynamic) converter,
      }) async {

    return _makeRequest(endPath, put,
        converter: converter,
        token: token,
        queryParameters: queryParameters,
        body: body,
        cancelToken: cancelToken
    );
  }

  Future<T> makeDelete<T>(
      String endPath, {
        String? token,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        required T Function(dynamic) converter,
      }) async {

    return _makeRequest(endPath, delete,
        converter: converter,
        token: token,
        queryParameters: queryParameters,
        body: body,
        cancelToken: cancelToken
    );
  }

  Future<T> makePatch<T>(
      String endPath, {
        String? token,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        CancelToken? cancelToken,
        required T Function(dynamic) converter,
      }) async {

    return _makeRequest(endPath, patch,
        converter: converter,
        token: token,
        queryParameters: queryParameters,
        body: body,
        cancelToken: cancelToken
    );
  }

  /// [_makeRequest] is called by each HTTP request methods above, by passing the right [method] string.
  /// The required values are: [endPath] string and [converter] function , callback called
  /// to convert the data received.
  /// If [token] is present, it adds it to [headers] before calling [dio.request].

  Future<T> _makeRequest<T>(String endPath, String method, {
      String? token,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body,
      CancelToken? cancelToken,
      required T Function(dynamic) converter,
    }) async{

    _addAuthorizationInHeaders(token);

    Response<dynamic> response;

    response = await dio.request(
      basePath + endPath,
      queryParameters: queryParameters,
      data: body,
      cancelToken: cancelToken,
      options: Options(
        headers: headers,
        method: method,
      ),
    );

    return converter(response.data != null && response.data.isNotEmpty ? response.data : response.statusCode);
  }

  void _initInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler,) async {
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) async {
          _printResponse(response);
          handler.next(response);
        },
        onError: (DioError e, ErrorInterceptorHandler handler) async {
          _printError(e);
          handler.next(e);
          // here if you want to handle http errors
        },
      ),
    );
  }

  void _addAuthorizationInHeaders(String? token){
    if(token != null) {
      headers["Authorization"] = "Bearer $token";
    }
  }

  void _printResponse(Response<dynamic> response) {
    debugPrint("|=================================================================================================");
    debugPrint("| METHOD: ${response.requestOptions.method.toUpperCase()}");
    debugPrint("| URL: ${response.requestOptions.uri}");
    debugPrint("| HEADERS: ${response.requestOptions.headers}");
    debugPrint("| BODY: ${response.requestOptions.data}");
    debugPrint("| RESPONSE: ${response.data?.toString()}");
    debugPrint("|=================================================================================================");
  }

  void _printError(DioError error) {
    if(error.response != null){
      debugPrint("|=================================================================================================");
      debugPrint("| ERROR");
      debugPrint("| METHOD: ${error.response!.requestOptions.method.toUpperCase()}");
      debugPrint("| URL: ${error.response!.requestOptions.uri}");
      debugPrint("| HEADERS: ${error.response!.requestOptions.headers}");
      debugPrint("| BODY: ${error.response!.requestOptions.data}");
      debugPrint("| RESPONSE: ${error.response!.data?.toString()}");
      debugPrint("|=================================================================================================");
    }else {
      debugPrint("|=================================================================================================");
      debugPrint("| DIO_ERROR: ${error.type}");
      debugPrint("|=================================================================================================");
    }
  }
}
