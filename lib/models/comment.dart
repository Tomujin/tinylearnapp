import 'package:flutter/cupertino.dart';
import 'package:tiny/models/models.dart';

class Comment {
  String id;
  String comment;
  var createdDate;
  User user;
  Comment({@required this.id, this.comment = "", this.createdDate, this.user});

  static Comment fromJson(Map<String, Object> json) {
    return Comment(
      id: json["id"] as String,
      comment: json["comment"] as String,
      createdDate: json["createdDate"] as String,
      user: User.fromDictionary(json["User"]),
    );
  }
}
