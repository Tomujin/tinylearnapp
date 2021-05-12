import 'package:tiny/models/models.dart';

class StoryContent {
  User user;
  String mediaType;
  Duration duration;
  String sourcePath;
  // String sourcePath;
  StoryContent({this.user, this.mediaType, this.duration, this.sourcePath});
  static StoryContent fromJson(Map<String, Object> json) {
    return StoryContent(
        user: User.fromDictionary(json["User"]),
        duration: json["duration"] as Duration,
        mediaType: json["mediaType"] as String,
        sourcePath: json["sourcePath"] as String);
  }
}
