import 'package:tiny/models/models.dart';

class PostReaction {
  String id;
  User user;
  ReactionType reactionType;

  PostReaction({
    this.id,
    this.user,
    this.reactionType,
  });

  static PostReaction fromJson(Map<String, Object> json) {
    return PostReaction(
      id: json["id"] as String,
      user: User.fromDictionary(json["User"]),
      reactionType: ReactionType.fromJson(json["ReactionType"]),
    );
  }
}
