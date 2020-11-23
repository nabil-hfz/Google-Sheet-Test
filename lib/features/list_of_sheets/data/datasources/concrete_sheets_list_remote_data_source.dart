import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/http/http_method.dart';
import 'package:google_sheet_test/core/resources/constants.dart';
import 'package:google_sheet_test/core/response/empty_response.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/api_response/google_sheets_list_response.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/models/google_sheet_model.dart';

import 'sheets_list_remote_data_source.dart';

class ConcreteSheetsListRemoteDataSource extends SheetsListRemoteDataSource {
  @override
  Future<Either<BaseError, List<GoogleSheetModel>>> getGoogleSheetsList({
    CancelToken cancelToken,
  }) async {
    return request<List<GoogleSheetModel>, GoogleSheetsListResponse>(
      responseStr: 'GoogleSheetsListResponse',
      converter: (json) => GoogleSheetsListResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_BASE,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<BaseError, Object>> deleteGoogleSheet({
    CancelToken cancelToken,
    GoogleSheetRequest googleSheetRequest,
  }) async {
    return request<Object, EmptyResponse>(
      responseStr: 'EmptyResponse',
      converter: (json) => EmptyResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_BASE,
      data: googleSheetRequest.toJson(),
      queryParameters :googleSheetRequest.toJson(),
      cancelToken: cancelToken,
    );
  }
}
