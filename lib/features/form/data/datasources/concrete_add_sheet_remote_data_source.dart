import 'dart:convert' as convert;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/http/http_method.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
import 'package:google_sheet_test/core/response/empty_response.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:http/http.dart' as http;

import 'add_sheet_remote_data_source.dart';

class ConcreteAddSheetRemoteDataSource extends AddSheetRemoteDataSource {
  @override
  Future<Either<BaseError, Object>> addGoogleSheet({
    GoogleSheetRequest data,
    CancelToken cancelToken,
  }) async {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_BASE,
      data: data.toJson(),
      queryParameters :data.toJson(),
      cancelToken: cancelToken,
    );
  }
}
