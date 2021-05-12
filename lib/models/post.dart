import 'package:flutter/cupertino.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/models/passage.dart';
import 'package:tiny/models/postCurriculum.dart';
import 'package:tiny/models/user_saved_post.dart';

class Post {
  String id;
  String postType;
  String title;
  String description;
  String publishedDate;
  Passage passage;
  User user;

  int totalCount;
  int reactionCount;
  String userSavedPostId;
  List<Comment> comments;
  List<Content> contents;
  List<UserSavedPost> userSavedPosts;
  List<PostReaction> postReactions;
  List<PostCurriculum> postCurriculums;
  bool isSaved;
  String isReacted;
  Post(
      {@required this.id,
      @required this.postType,
      this.title,
      this.description = "",
      this.publishedDate,
      this.passage,
      this.user,
      this.totalCount,
      this.reactionCount,
      this.comments,
      this.contents,
      this.userSavedPosts,
      this.userSavedPostId,
      this.postReactions,
      this.isSaved,
      this.postCurriculums,
      this.isReacted = ""});
  Future<void> personLiked(userId) async {
    // todo like
  }

  static Post fromJson(Map<String, Object> json) {
    Post post = Post(
        id: json["id"] as String,
        postType: json["postType"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
        publishedDate: json["publishedDate"] as String,
        passage:
            json["Passage"] == null ? null : Passage.fromJson(json["Passage"]),
        user: User.fromDictionary(json["User"]),
        totalCount: json["totalCount"] as int,
        reactionCount: json["reactionCount"] as int,
        comments: (json["PostComments"] as List)
            .map<Comment>((x) => Comment.fromJson(x))
            .toList(),
        contents: (json["Contents"] as List)
            .map<Content>((x) => Content.fromJson(x))
            .toList(),
        userSavedPostId: json["userSavedPostId"] as String,
        postReactions: (json["PostReactions"] as List)
            .map((e) => PostReaction.fromJson(e))
            .toList(),
        isSaved: !((json["userSavedPostId"] as String)?.isEmpty ?? true),
        postCurriculums: (json["PostCurriculum"] as List)
            .map((e) => PostCurriculum.fromJson(e))
            .toList(),
        isReacted: json["isReacted"] as String);

    post.contents.forEach((element) {
      element.setPost(post);
    });

    return post;
  }

  void changeSavedState({bool saved, String id}) {
    isSaved = saved;
    userSavedPostId = id;
  }
}
