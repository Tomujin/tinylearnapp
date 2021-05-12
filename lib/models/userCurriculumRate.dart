import 'dart:ffi';

class UserCurriculumRate {
  String id;
  String userCurriculumId;
  String curriculumId;
  double rate;

  UserCurriculumRate({
    this.id,
    this.userCurriculumId,
    this.curriculumId,
    this.rate,
  });

  static UserCurriculumRate fromJson(Map<String, Object> json) {
    return UserCurriculumRate(
      id: json["id"] as String,
      userCurriculumId: json["userCurriculumId"] as String,
      curriculumId: json["curriculumId"] as String,
      rate: double.tryParse(json["rate"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userCurriculumId": this.userCurriculumId,
      "curriculumId": this.curriculumId,
      "rate": this.rate,
    };
  }

  @override
  String toString() {
    return 'UserCurriculumRate { id: $id, userCurriculumId: $userCurriculumId, rate: $rate, curriculumId: $curriculumId }';
  }
}
