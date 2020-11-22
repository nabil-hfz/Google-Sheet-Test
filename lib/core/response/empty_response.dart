import 'package:json_annotation/json_annotation.dart';

import '../model/message_model.dart';
import 'api_response.dart';

part 'empty_response.g.dart';

@JsonSerializable()
class EmptyResponse extends ApiResponse<Object> {
  EmptyResponse(
    bool isOk,
    MessageModel message,
    Object result,
  ) : super(isOk, message, result);

  factory EmptyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);
}
