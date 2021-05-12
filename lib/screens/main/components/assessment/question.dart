class Post {
  String id;
  String postType;
  String title;
  String description;
  bool isPublished;
  DateTime publishDate;
  User user;
  DateTime createdAt;
  DateTime updatedAt;
  List<Content> contents;
  Post(
      {this.id,
      this.postType,
      this.title,
      this.description,
      this.isPublished,
      this.publishDate,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.contents});
}

class Content {
  String id;
  int orderNum;
  Post post;
  String contentType;
  String mediaType;
  String contentText;
  String sourcePath;
  String voiceOverPath;
  double contentSize;
  String answerType;
  DateTime createdAt;
  DateTime updatedAt;
  List<ContentAnswer> answers;
  Content(
      {this.id,
      this.orderNum,
      this.post,
      this.contentType,
      this.mediaType,
      this.contentText,
      this.sourcePath,
      this.voiceOverPath,
      this.contentSize,
      this.answerType,
      this.createdAt,
      this.updatedAt,
      this.answers});
}

class ContentAnswer {
  String id;
  Content content;
  String mediaType;
  String answer;
  String sourcePath;
  double point;
  ContentAnswer(
      {this.id,
      this.content,
      this.mediaType,
      this.answer,
      this.sourcePath,
      this.point});
}

class Question {
  String title;
  String description;
  User user;
  String sourcePath;
  QuestionType type;
  DifficultyLevel difficultyLevel;

  List<LearningObject> learningObjects;
  List<Answer> answers;

  Question(this.title, this.description, this.sourcePath, this.type,
      this.difficultyLevel, this.learningObjects, this.answers);
}

class Answer {
  String answer;
  double point;

  Answer(this.answer, this.point);
}

class User {}

enum QuestionType { Multiple, SPR, Voice }
enum DifficultyLevel { Hard, Medium, Easy }

class LearningObject {}
