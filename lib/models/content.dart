import 'package:tiny/models/answer.dart';
import 'package:tiny/models/post.dart';

class Content {
  String id;
  int orderNum;
  String mediaType;
  String contentText;
  String sourcePath;
  String voiceOverPath;
  String answerType;
  List<Answer> answers;
  Post post;
  Answer userAnswer;
  String answerText;
  Content(
      {this.id,
      this.orderNum,
      this.mediaType,
      this.contentText,
      this.sourcePath,
      this.voiceOverPath,
      this.answerType,
      this.answers,
      this.post});

  static Content fromJson(Map<String, Object> json) {
    //print(json["orderNum"]);
    return Content(
        id: json["id"] as String,
        orderNum: json["orderNum"] as int,
        mediaType: json["mediaType"] as String,
        contentText: json["contentText"] as String,
        sourcePath: json["sourcePath"] as String,
        voiceOverPath: json["voiceOverPath"] as String,
        answerType: json["answerType"] as String,
        answers: json["Answers"] == null
            ? null
            : (json["Answers"] as List)
                .map<Answer>((x) => Answer.fromJson(x))
                .toList());
  }

  void setPost(Post _post) {
    post = _post;
  }

  void setUserAnswer(int answerIndex, String _answerText) {
    userAnswer = this.answers[answerIndex];
    answerText = _answerText;
  }
}
