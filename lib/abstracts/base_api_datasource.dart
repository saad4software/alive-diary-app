import 'dart:io';

import 'package:alive_diary/abstracts/data_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';


abstract class BaseApiRepository {

  @protected
  Future<DataState<T>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      final okStatus = [HttpStatus.ok, HttpStatus.created, HttpStatus.accepted,];
      if (okStatus.contains(httpResponse.response.statusCode) ) {
        return DataSuccess(httpResponse.data);
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (error) {

      return DataFailed(error);
    }
  }
}
