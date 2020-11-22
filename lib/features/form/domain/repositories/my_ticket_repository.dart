import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/repositry/repository.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';

abstract class AddSheetRepository extends Repository {
  Future<Result<BaseError, Object>> submitData({
    AddSheetRequest addSheetRequest,
    CancelToken cancelToken,
  });
}
