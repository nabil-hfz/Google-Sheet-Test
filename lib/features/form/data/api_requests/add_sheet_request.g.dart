// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_sheet_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSheetRequest _$GoogleSheetRequestFromJson(Map<String, dynamic> json) {
  return GoogleSheetRequest(
    id: json['id'] as String,
    name: json['name'] as String,
    mobileNumber: json['mobileNumber'] as String,
    modelNumber: json['modelNumber'] as String,
    purchaseDate: json['purchaseDate'] as String,
    email: json['email'] as String,
    httpMethod: json['httpMethod'] as String,
  );
}

Map<String, dynamic> _$GoogleSheetRequestToJson(GoogleSheetRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'modelNumber': instance.modelNumber,
      'purchaseDate': instance.purchaseDate,
      'email': instance.email,
      'httpMethod': instance.httpMethod,
    };
