import 'package:dio/dio.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/form/data/datasources/add_sheet_remote_data_source.dart';
import 'package:google_sheet_test/features/form/domain/repositories/add_sheet_repository.dart';

class ConcreteAddSheetRepository extends AddGoogleSheetRepository {
  final AddSheetRemoteDataSource remoteDataSource;

  ConcreteAddSheetRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, Object>> addGoogleSheet({
    GoogleSheetRequest addSheetRequest,
    CancelToken cancelToken,
  }) async {
    print(addSheetRequest);
    final remoteResult = await remoteDataSource.addGoogleSheet(
      data: addSheetRequest,
      cancelToken: cancelToken,
    );

    return executeForNoData(remoteResult: remoteResult);
  }
}
