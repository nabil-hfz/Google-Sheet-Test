import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/model/base_model.dart';
import 'package:google_sheet_test/features/list_of_sheets/domain/entities/google_sheet_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_sheet_model.g.dart';

@JsonSerializable()
class GoogleSheetModel extends BaseModel<GoogleSheetEntity> {
  final String id;
  final String name;
  final String mobileNumber;
  final String modelNumber;
  final String purchaseDate;
  final String email;

  GoogleSheetModel({
    @required this.id,
    @required this.name,
    @required this.mobileNumber,
    @required this.modelNumber,
    @required this.purchaseDate,
    @required this.email,
  });

  Map<String, dynamic> toJson() => _$GoogleSheetModelToJson(this);

  factory GoogleSheetModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleSheetModelFromJson(json);

  @override
  GoogleSheetEntity toEntity() {
    return GoogleSheetEntity(
      id: this.id,
      name: this.name,
      email: this.email,
      purchaseDate: this.purchaseDate,
      mobileNumber: this.mobileNumber,
      modelNumber: this.modelNumber,
    );
  }
}
