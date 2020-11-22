import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sheet_test/core/errors/base_error.dart';
import 'package:google_sheet_test/core/params/base_params.dart';
import 'package:google_sheet_test/core/results/result.dart';
import 'package:google_sheet_test/core/usecases/usecase.dart';
import 'package:google_sheet_test/features/form/data/api_requests/add_sheet_request.dart';
import 'package:google_sheet_test/features/form/domain/repositories/my_ticket_repository.dart';
//import 'package:google_sheet_test/features/user_management/domain/repositories/user_repository.dart';

class AddSheetParams extends BaseParams {
  final AddSheetRequest addSheetRequest;

  AddSheetParams({
    @required this.addSheetRequest,
    @required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class AddSheetUseCase extends UseCase<Object, AddSheetParams> {
  final AddSheetRepository repository;

  AddSheetUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(AddSheetParams params) =>
      repository.submitData(
        addSheetRequest:params.addSheetRequest,
        cancelToken: params.cancelToken,
      );
}
