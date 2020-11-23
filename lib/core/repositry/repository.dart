import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/entity/base_entity.dart';
import 'package:google_sheet_test/core/model/base_model.dart';

import '../errors/base_error.dart';
import '../results/result.dart';

abstract class Repository {
  Result<BaseError, Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>({
    @required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, Model>).value.toEntity(),
      );
    } else {
      return Result(error: (remoteResult as Left<BaseError, Model>).value);
    }
  }

  Result<BaseError, List<Entity>> executeForList<
          Model extends BaseModel<Entity>, Entity extends BaseEntity>(
      {@required Either<BaseError, List<Model>> remoteResult}) {
    if (remoteResult != null && remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, List<Model>>)
            .value
            .map((model) => model.toEntity())
            .toList(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<BaseError, List<Model>>)?.value,
      );
    }
  }

  Result<BaseError, Object> executeForNoData({
    @required Either<BaseError, Object> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: Object());
    }
    return Result(error: (remoteResult as Left<BaseError, Object>).value);
  }
}
