import 'package:dartz/dartz.dart';

class Result<Error, Data> {
  Tuple2<Error, Data> _tuple;

  Result({Error error, Data data}) {
    _tuple = Tuple2<Error, Data>(error, data);
  }

  Error get error => _tuple.value1;

  bool get hasError => _tuple.value1 != null;

  Data get data => _tuple.value2;

  bool get hasData => _tuple.value2 != null;

  bool get hasErrorOnly => hasError && !hasData;

  bool get hasDataOnly => hasData && !hasError;
}
