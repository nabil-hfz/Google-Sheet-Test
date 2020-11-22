
import '../model/message_model.dart';
abstract class ApiResponse<T> {
  final bool isOk;
  final MessageModel message;
  final T result;

  ApiResponse(
    this.isOk,
    this.message,
    this.result,
  );
}


