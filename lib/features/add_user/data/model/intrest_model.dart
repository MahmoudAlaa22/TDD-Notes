// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IntrestModel {
  final String? intrestText;
  final String? id;
  IntrestModel({
    this.intrestText,
    this.id,
  });

  IntrestModel copyWith({
    String? intrestText,
    String? id,
  }) {
    return IntrestModel(
      intrestText: intrestText ?? this.intrestText,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'intrestText': intrestText,
      'id': id,
    };
  }

  factory IntrestModel.fromMap(Map<String, dynamic> map) {
    return IntrestModel(
      intrestText: map['intrestText'] != null ? map['intrestText'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IntrestModel.fromJson(String source) => IntrestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IntrestModel(intrestText: $intrestText, id: $id)';

}
