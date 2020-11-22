import 'package:google_sheet_test/core/errors/base_error.dart';

class ApiError extends BaseError{
  final String message;

  ApiError({this.message});
}