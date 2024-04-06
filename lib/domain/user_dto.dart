import 'dart:convert';

class UserModel {
  final String? email;
  UserModel({
    this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (email != null) {
      result.addAll({'email': email});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? email,
  }) {
    return UserModel(
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'UserModel(email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}
