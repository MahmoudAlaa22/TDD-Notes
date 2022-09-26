// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddUserModel {
  final String? username;
  final String? password;
  final String? email;
  final String? imageAsBase64;
  final String? intrestId;
  AddUserModel({
    this.username,
    this.password,
    this.email,
    this.imageAsBase64,
    this.intrestId,
  });

  AddUserModel copyWith({
    String? username,
    String? password,
    String? email,
    String? imageAsBase64,
    String? intrestId,
  }) {
    return AddUserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      imageAsBase64: imageAsBase64 ?? this.imageAsBase64,
      intrestId: intrestId ?? this.intrestId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Username': username,
      'Password': password,
      'Email': email,
      'ImageAsBase64': imageAsBase64,
      'IntrestId': intrestId,
    };
  }

  factory AddUserModel.fromMap(Map<String, dynamic> map) {
    return AddUserModel(
      username: map['Username'] != null ? map['Username'] as String : null,
      password: map['Password'] != null ? map['Password'] as String : null,
      email: map['Email'] != null ? map['Email'] as String : null,
      imageAsBase64: map['ImageAsBase64'] != null ? map['ImageAsBase64'] as String : null,
      intrestId: map['IntrestId'] != null ? map['IntrestId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddUserModel.fromJson(String source) => AddUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddUserModel(Username: $username, Password: $password, Email: $email, ImageAsBase64: $imageAsBase64, IntrestId: $intrestId)';
  }
}
