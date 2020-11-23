import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/params/base_params.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/core/usecases/usecase.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/form/domain/repositories/add_sheet_repository.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/repositories/sheets_list_repository.dart';

class DeleteGoogleSheetParams extends BaseParams {
  final GoogleSheetRequest googleSheetRequest;

  DeleteGoogleSheetParams({
    @required this.googleSheetRequest,
    @required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class DeleteGoogleSheetUseCase extends UseCase<Object, DeleteGoogleSheetParams> {
  final SheetsListRepository repository;

  DeleteGoogleSheetUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteGoogleSheetParams params) =>
      repository.deleteGoogleSheet(
        googleSheetRequest: params.googleSheetRequest,
        cancelToken: params.cancelToken,
      );
}
