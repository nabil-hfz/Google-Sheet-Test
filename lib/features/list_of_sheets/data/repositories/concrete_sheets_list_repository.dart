import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/datasources/sheets_list_remote_data_source.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/models/google_sheet_model.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/repositories/sheets_list_repository.dart';

class ConcreteSheetsListRepository extends SheetsListRepository {
  final SheetsListRemoteDataSource remoteDataSource;

  ConcreteSheetsListRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, List<GoogleSheetEntity>>> getAllGoogleSheets({
    CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.getGoogleSheetsList(
      cancelToken: cancelToken,
    );

     return executeForList<GoogleSheetModel, GoogleSheetEntity>(
      remoteResult: remoteResult,
    );
  }

  @override
  Future<Result<BaseError, Object>> deleteGoogleSheet({
    GoogleSheetRequest googleSheetRequest,
    CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.deleteGoogleSheet(
      cancelToken: cancelToken,
      googleSheetRequest: googleSheetRequest,
    );

    return executeForNoData(remoteResult: remoteResult);

  }
}
