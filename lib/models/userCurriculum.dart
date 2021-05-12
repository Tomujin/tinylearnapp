import './models.dart';

class UserCurriculum {
  String id;
  String userId;
  int point;
  DateTime applyingDate;
  String curriculumId;
  List<UserCurriculumRate> userCurriculumRates;

  UserCurriculum(
      {this.id,
      this.userId,
      this.point,
      this.applyingDate,
      this.curriculumId,
      this.userCurriculumRates});

  static UserCurriculum fromJson(Map<String, Object> json) {
    return UserCurriculum(
        id: json["id"] as String,
        userId: json["userId"] as String,
        point: json["point"] as int,
        applyingDate: json["applyingDate"] == null
            ? null
            : DateTime.tryParse(json["applyingDate"]),
        curriculumId: json["curriculumId"] as String,
        userCurriculumRates: json["UserCurriculumRate"] == null
            ? null
            : (json["UserCurriculumRate"] as List)
                .map<UserCurriculumRate>((x) => UserCurriculumRate.fromJson(x))
                .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userId": this.userId,
      "point": this.point,
      "applyingDate": this.applyingDate?.toIso8601String(),
      "curriculumId": this.curriculumId,
      "userCurriculumRates": this.userCurriculumRates
      //== null
      //? null
      //: this.userCurriculumRates.map((x) => x.toJson()).toList()
    };
  }

  @override
  String toString() {
    return 'UserCurriculum { id: $id, userId: $userId, point: $point, applyingDate: $applyingDate, curriculumId: $curriculumId , userCurriculumRates: $userCurriculumRates }';
  }
}
