import 'dart:convert';

import 'package:chat_system/core/constants.dart';

class Message {
  final String? message;
  final String? id;
  final DateTime? createdAt;

  Message({
    this.message,
    this.id,
    this.createdAt,
  });

  Message copyWith({
    String? message,
    String? id,
    DateTime? createdAt,
  }) {
    return Message(
      message: message ?? this.message,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (message != null) {
      result.addAll({'message': message});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      id: map['id'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));

  @override
  String toString() =>
      'Message(message: $message, id: $id, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.message == message &&
        other.id == id &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => message.hashCode ^ id.hashCode ^ createdAt.hashCode;
}
