import 'dart:convert';

class UserModel {
  final String? email;
  final String? id;
  final String? username;
  UserModel({
    this.email,
    this.id,
    this.username,
  });

  UserModel copyWith({
    String? email,
    String? id,
    String? username,
  }) {
    return UserModel(
      email: email ?? this.email,
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (email != null) {
      result.addAll({'email': email});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (username != null) {
      result.addAll({'username': username});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      id: map['id'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, id: $id, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.email == email &&
        other.id == id &&
        other.username == username;
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode ^ username.hashCode;
}
