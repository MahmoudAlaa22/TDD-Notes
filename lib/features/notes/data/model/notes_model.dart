// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotesModel {
  final String? text;
  final String? placeDateTime;
  final String? userId;
  final String? id;
  NotesModel({
    this.text,
    this.placeDateTime,
    this.userId,
    this.id,
  });

  NotesModel copyWith({
    String? text,
    String? placeDateTime,
    String? userId,
    String? id,
  }) {
    return NotesModel(
      text: text ?? this.text,
      placeDateTime: placeDateTime ?? this.placeDateTime,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'placeDateTime': placeDateTime,
      'userId': userId,
      'id': id,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      text: map['text'] != null ? map['text'] as String : null,
      placeDateTime: map['placeDateTime'] != null ? map['placeDateTime'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) => NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoresModel(text: $text, placeDateTime: $placeDateTime, userId: $userId, id: $id)';
  }

}
