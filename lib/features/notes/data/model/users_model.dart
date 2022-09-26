
import 'dart:convert';

class UsersModel {
  final String? username;
  final String? password;
  final String? email;
  final String? imageAsBase64;
  final String? intrestId;
  final String? id;
  UsersModel({
    this.username,
    this.password,
    this.email,
    this.imageAsBase64,
    this.intrestId,
    this.id,
  });

  UsersModel copyWith({
    String? username,
    String? password,
    String? email,
    String? imageAsBase64,
    String? intrestId,
    String? id,
  }) {
    return UsersModel(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      imageAsBase64: imageAsBase64 ?? this.imageAsBase64,
      intrestId: intrestId ?? this.intrestId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'email': email,
      'imageAsBase64': imageAsBase64,
      'intrestId': intrestId,
      'id': id,
    };
  }

  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      imageAsBase64: map['imageAsBase64'] != null ? map['imageAsBase64'] as String : null,
      intrestId: map['intrestId'] != null ? map['intrestId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersModel.fromJson(String source) => UsersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsersModel(username: $username, password: $password, email: $email, imageAsBase64: $imageAsBase64, intrestId: $intrestId, id: $id)';
  }

}
