import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/repositry/repository.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';

abstract class AddGoogleSheetRepository extends Repository {
  Future<Result<BaseError, Object>> addGoogleSheet({
    GoogleSheetRequest addSheetRequest,
    CancelToken cancelToken,
  });
}
