import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/remote_data_source/remote_data_source.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/models/google_sheet_model.dart';

abstract class SheetsListRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<GoogleSheetModel>>> getGoogleSheetsList({
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> deleteGoogleSheet({
    CancelToken cancelToken,
    GoogleSheetRequest googleSheetRequest,
  });
}
