// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyResponse _$EmptyResponseFromJson(Map<String, dynamic> json) {
  return EmptyResponse(
    json['isOk'] as bool,
    json['message'] == null
        ? null
        : MessageModel.fromJson(json['message'] as Map<String, dynamic>),
    json['result'],
  );
}

Map<String, dynamic> _$EmptyResponseToJson(EmptyResponse instance) =>
    <String, dynamic>{
      'isOk': instance.isOk,
      'message': instance.message,
      'result': instance.result,
    };
