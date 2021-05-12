import 'dart:ffi';

import 'package:tiny/models/models.dart';

class PostView {
  String id;
  User user;
  Post post;
  Float visiblePercent;
  int watchIndex;
  DateTime watchDate;
  PostView(
      {this.id,
      this.user,
      this.post,
      this.visiblePercent,
      this.watchIndex,
      this.watchDate});

  static PostView fromJson(Map<String, Object> json) {
    return PostView(
        id: json["id"] as String,
        user: User.fromDictionary(json["User"]),
        post: Post.fromJson(json["Post"]),
        visiblePercent: json["visiblePercent"] as Float,
        watchIndex: json["watchIndex"] as int,
        watchDate: json["watchDate"] as DateTime);
  }
}
//  (json["Contents"] as List)
//             .map<Content>((x) => Content.fromJson(x))
//             .toList(),
