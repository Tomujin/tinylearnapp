import 'package:tiny/models/models.dart';
import 'package:tiny/models/storyContent.dart';

// enum MediaType { Video, Image, Voice, Text, Latex }

class Story {
  User user;
  DateTime publishedDate;
  List<StoryContent> storyContent;
  Story({
    this.user,
    this.publishedDate,
    this.storyContent,
  });
  static Story fromJson(Map<String, Object> json) {
    return Story(
        user: User.fromJson(json["User"]),
        // publishedDate: json["publishedDate"] as DateTime,
        storyContent: (json["StoryContent"] as List)
            .map((e) => StoryContent.fromJson(e))
            .toList());
  }
}
