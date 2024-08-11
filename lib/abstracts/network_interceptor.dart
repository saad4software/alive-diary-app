import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class NetworkInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    debugPrint("--> ${options.method.toUpperCase()} ${options.baseUrl + options.path}");
    debugPrint("headers -->");

    options.headers.forEach((key, value) {debugPrint("$key $value");}); // printing headers if needed
    if (options.data != null && options.method != "GET") {
      debugPrint("Body:\n${options.data is Map<String, dynamic> ? printJson(options.data) : options.data}");
    }
    debugPrint("--> END ${options.method}");

  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    debugPrint('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri.toString()}');
    debugPrint("<-- ${err.message} ${(err.requestOptions.uri.toString())}");
    if (err.response?.data != null){
      debugPrint("${err.response?.data is Map<String, dynamic> ? printJson(err.response?.data) : err.response?.data}");
    }
    debugPrint("<-- End error");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    debugPrint("<-- ${response.statusCode} ${(response.requestOptions.uri.toString())}");
    debugPrint("Body:\n${response.data is Map<String, dynamic> ? printJson(response.data) : response.data}");
    debugPrint("<-- END HTTP");
  }

  String printJson(Map<String, dynamic> map){
    final str = json.encode(map);
    final object = json.decode(str);
    final prettyString = const JsonEncoder.withIndent('  ').convert(object);
    return prettyString;
  }
}