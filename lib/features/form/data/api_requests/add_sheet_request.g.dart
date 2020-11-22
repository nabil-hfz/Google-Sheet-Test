// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddSheetRequest _$AddSheetRequestFromJson(Map<String, dynamic> json) {
  return AddSheetRequest(
    name: json['name'] as String,
    mobileNumber: json['mobileNumber'] as String,
    modelNumber: json['modelNumber'] as String,
    purchaseDate: json['purchaseDate'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$AddSheetRequestToJson(AddSheetRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'modelNumber': instance.modelNumber,
      'purchaseDate': instance.purchaseDate,
      'email': instance.email,
    };
