import 'package:flutter/cupertino.dart';

class CurriculumSchool {
  String id;
  String name;
  CurriculumSchool({@required this.id, this.name = ""});

  static CurriculumSchool fromJson(Map<String, Object> json) {
    return CurriculumSchool(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}
