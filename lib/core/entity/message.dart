import 'package:flutter/foundation.dart';
 import 'package:google_sheet_test/core/model/message_model.dart';

import 'base_entity.dart';

class Message extends BaseEntity {
  final MessageType type;
  final String content;
  final int code;

  Message({
    @required this.type,
    @required this.content,
    @required this.code,
  });

  @override
  List<Object> get props => [
        this.type,
        this.code,
        this.content,
      ];
}
