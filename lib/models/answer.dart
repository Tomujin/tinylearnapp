import 'package:flutter/cupertino.dart';

class Answer {
  String id;
  String mediaType;
  int point;
  String answer;
  Answer({
    @required this.id,
    @required this.mediaType,
    this.point = 0,
    this.answer = "",
  });

  static Answer fromJson(Map<String, Object> json) {
    return Answer(
      id: json["id"] as String,
      mediaType: json["mediaType"] as String,
      point: json["Point"] as int,
      answer: json["answer"] as String,
    );
  }
}
