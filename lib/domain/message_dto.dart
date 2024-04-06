import 'package:chat_system/core/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

typedef Json = Map<String, dynamic>;

@JsonSerializable()
class Message {
  final String? message;
  final String? id;
  @TimestampConverter()
  final DateTime? createdAt;
  final List<Message>? messages;

  Message({this.message, this.id, this.createdAt, this.messages});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  factory Message.fromFirestore(DocumentSnapshot<Json> doc) {
    return Message.fromJson(doc.data() ?? {});
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
