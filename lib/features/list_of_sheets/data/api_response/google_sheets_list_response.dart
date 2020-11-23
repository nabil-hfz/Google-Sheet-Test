import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/model/message_model.dart';
import 'package:google_sheet_test/core/response/api_response.dart';
import 'package:google_sheet_test/features/list_of_sheets/data/models/google_sheet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_sheets_list_response.g.dart';

@JsonSerializable()
class GoogleSheetsListResponse extends ApiResponse<List<GoogleSheetModel>> {
  final List<GoogleSheetModel> list;
  final MessageModel message;
  final bool isOk;

  GoogleSheetsListResponse({
    @required this.message,
    @required this.list,
    @required this.isOk,
  }) : super(isOk,message, list);

  Map<String, dynamic> toJson() => _$GoogleSheetsListResponseToJson(this);
  factory GoogleSheetsListResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleSheetsListResponseFromJson(json);
}
