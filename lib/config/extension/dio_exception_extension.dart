

import 'package:alive_diary/domain/models/responses/ErrorResponse.dart';
import 'package:dio/dio.dart';

extension DioExceptionExtension on DioException {

  String getErrorMessage() {
    final msg = response?.data == null ?
    message :
    ErrorResponse
        .fromJson(response?.data)
        .message?.trim();

    return msg ?? "Unexpected error";
  }
}