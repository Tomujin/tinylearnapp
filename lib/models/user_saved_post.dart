import 'package:flutter/cupertino.dart';
import 'package:tiny/models/post.dart';
import 'package:tiny/models/user.dart';

class UserSavedPost {
  String id;
  bool isPublic;
  List<Post> posts;
  User user;

  UserSavedPost({this.id, this.isPublic, this.posts, this.user});

  static UserSavedPost fromJson(Map<String, Object> json) {
    return UserSavedPost(
      id: json["id"] as String,
      isPublic: json["mediaType"] as bool,
      posts: (json["Posts"] as List)?.map((e) => Post.fromJson(e))?.toList(),
      user: User.fromDictionary(json["User"]),
    );
  }
}
