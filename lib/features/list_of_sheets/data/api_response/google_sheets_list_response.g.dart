// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_sheets_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleSheetsListResponse _$GoogleSheetsListResponseFromJson(
    Map<String, dynamic> json) {
  return GoogleSheetsListResponse(
    message: json['message'] == null
        ? null
        : MessageModel.fromJson(json['message'] as Map<String, dynamic>),
    list: (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleSheetModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isOk: json['isOk'] as bool,
  );
}

Map<String, dynamic> _$GoogleSheetsListResponseToJson(
        GoogleSheetsListResponse instance) =>
    <String, dynamic>{
      'list': instance.list,
      'message': instance.message,
      'isOk': instance.isOk,
    };
