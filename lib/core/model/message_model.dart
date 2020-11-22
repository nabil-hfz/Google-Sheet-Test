import 'package:flutter/foundation.dart';
 import 'package:google_sheet_test/core/entity/message.dart';
import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'message_model.g.dart';

enum MessageType { Error, Success }

@JsonSerializable()
class MessageModel extends BaseModel<Message> {
  final MessageType type;
  final String content;
  final int code;

  MessageModel({
    @required this.type,
    @required this.code,
    @required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  MessageModel copyWith({String type, String content, String code}) =>
      MessageModel(
        type: type ?? this.type,
        code: code ?? this.code,
        content: content ?? this.content,
      );

  @override
  Message toEntity() {
    return Message(
      type: this.type,
      code: this.code,
      content: this.content,
    );
  }
}
