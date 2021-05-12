import 'package:flutter/cupertino.dart';

class Passage {
  String id;
  String mediaType;
  String text;
  Passage({
    @required this.id,
    @required this.mediaType,
    this.text = "",
  });

  static Passage fromJson(Map<String, Object> json) {
    return Passage(
      id: json["id"] as String,
      mediaType: json["mediaType"] as String,
      text: json["text"] as String,
    );
  }
}
