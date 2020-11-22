
import 'package:google_sheet_test/core/entity/base_entity.dart';

// ignore: must_be_immutable
class MessageEntity extends BaseEntity{
  String type;
  String content;

  MessageEntity({
    this.type,
    this.content,
  });

  @override
   List<Object> get props => [];
}