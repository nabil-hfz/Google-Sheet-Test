// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSheetModel _$GoogleSheetModelFromJson(Map<String, dynamic> json) {
  return GoogleSheetModel(
    id: json['id'] as String,
    name: json['name'] as String,
    mobileNumber: json['mobileNumber'] as String,
    modelNumber: json['modelNumber'] as String,
    purchaseDate: json['purchaseDate'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$GoogleSheetModelToJson(GoogleSheetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'modelNumber': instance.modelNumber,
      'purchaseDate': instance.purchaseDate,
      'email': instance.email,
    };
