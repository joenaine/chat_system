import 'package:chat_system/core/constants.dart';

class Message {
  final String? message;
  final String? id;

  Message({this.message, this.id});

  factory Message.fromJson(json) {
    return Message(
      message: json[kMessage],
      id: json['id'],
    );
  }
}
