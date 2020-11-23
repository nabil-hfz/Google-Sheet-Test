import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/remote_data_source/remote_data_source.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';

abstract class AddSheetRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, Object>> addGoogleSheet({
    GoogleSheetRequest data,
    CancelToken cancelToken,
  });
}
