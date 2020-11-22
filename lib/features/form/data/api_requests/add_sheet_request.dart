import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_sheet_request.g.dart';

@JsonSerializable()
class AddSheetRequest {

  final String name;
  final String mobileNumber;
  final String modelNumber;
  final String purchaseDate;
  final String email;

  AddSheetRequest({
    @required this.name,
    @required this.mobileNumber,
    @required this.modelNumber,
    @required this.purchaseDate,
    @required this.email,
   });

  Map<String, dynamic> toJson() => _$AddSheetRequestToJson(this);
}
