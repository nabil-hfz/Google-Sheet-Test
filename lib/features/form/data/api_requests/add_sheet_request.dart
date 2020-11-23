import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_sheet_request.g.dart';

@JsonSerializable()
class GoogleSheetRequest {

  final String id;
  final String name;
  final String mobileNumber;
  final String modelNumber;
  final String purchaseDate;
  final String email;
  final String httpMethod;

  GoogleSheetRequest({
    @required this.id,
    @required this.name,
    @required this.mobileNumber,
    @required this.modelNumber,
    @required this.purchaseDate,
    @required this.email,
    @required this.httpMethod,
   });

  Map<String, dynamic> toJson() => _$GoogleSheetRequestToJson(this);

}
