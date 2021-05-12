import 'package:flutter/cupertino.dart';

class Career {
  String id;
  String name;
  Career({@required this.id, this.name = ""});

  static Career fromJson(Map<String, Object> json) {
    return Career(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}
