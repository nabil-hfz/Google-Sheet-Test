import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/errors/custom_error.dart';
import 'package:google_sheet_test/core/http/http.dart';
import 'package:google_sheet_test/core/response/api_response.dart';

import '../errors/base_error.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, Data>>
      request<Data, Response extends ApiResponse<Data>>({
    @required String responseStr,
    @required Response Function(Map<String, dynamic>) converter,
    @required HttpMethod method,
    @required String url,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    CancelToken cancelToken,
  }) async {
    assert(responseStr != null);
    assert(converter != null);
    assert(method != null);
    assert(url != null);

    // Register the response.
    ModelsFactory.getInstance().registerModel(responseStr, converter);

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      queryParameters: queryParameters ?? {},
      data: data,
      headers: {},
      cancelToken: cancelToken,
    );

    if (response != null && response.isLeft()) {
      return Left((response as Left<BaseError, Response>).value);
    } else if (response != null && response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      if (resValue.isOk != null && resValue.isOk) {
        return Right(resValue.result);
      } else if (resValue.isOk != null && !resValue.isOk) {
        return Left(CustomError(message: resValue.message.content));
      }
      return null;
    }
    return null;
  }
}
