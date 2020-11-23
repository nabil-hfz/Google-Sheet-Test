import 'package:flutter/foundation.dart';
import 'package:google_sheet_test/core/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';


class GoogleSheetEntity extends BaseEntity {
  final String id;
  final String name;
  final String mobileNumber;
  final String modelNumber;
  final String purchaseDate;
  final String email;

  GoogleSheetEntity({
    @required this.id,
    @required this.name,
    @required this.mobileNumber,
    @required this.modelNumber,
    @required this.purchaseDate,
    @required this.email,
  });

  @override
  List<Object> get props => [
    this.id,
        this.name,
        this.mobileNumber,
        this.modelNumber,
        this.purchaseDate,
        this.email,
      ];
}
