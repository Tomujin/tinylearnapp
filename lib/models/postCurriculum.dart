import 'package:flutter/cupertino.dart';
import 'package:tiny/models/post.dart';

import 'curriculum.dart';

class PostCurriculum {
  String id;
  Curriculum curriculum;
  Post post;

  PostCurriculum({
    @required this.id,
    this.curriculum,
    this.post,
  });

  static PostCurriculum fromJson(Map<String, Object> json) {
    return PostCurriculum(
      id: json["id"] as String,
      curriculum: Curriculum.fromJson(json["Curriculum"]),
      //  post: json["Post"] as Post,
    );
  }
}
