import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/params/base_params.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/core/usecases/usecase.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/models/google_sheet_model.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/repositories/sheets_list_repository.dart';

class GetAllGoogleSheetsParams extends BaseParams {
  GetAllGoogleSheetsParams({
    @required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class GetAllGoogleSheetsUseCase extends UseCase<List<GoogleSheetEntity>, GetAllGoogleSheetsParams> {
  final SheetsListRepository repository;

  GetAllGoogleSheetsUseCase(this.repository);

  @override
  Future<Result<BaseError, List<GoogleSheetEntity>>> call(GetAllGoogleSheetsParams params) =>

      repository.getAllGoogleSheets(
        cancelToken: params.cancelToken,
      );
}
