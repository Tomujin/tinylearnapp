import 'package:flutter/cupertino.dart';
import 'package:tiny/models/models.dart';

class Curriculum {
  String id;
  String name;
  int point;
  String parentId;
  List<Curriculum> childCurriculums;
  Curriculum parentCurriculum;
  List<CurriculumSchool> curriculumSchools;
  List<UserCurriculumRate> userCurriculumRates;

  Curriculum(
      {@required this.id,
      this.name = "",
      this.point = 0,
      this.curriculumSchools,
      this.childCurriculums,
      this.parentCurriculum,
      this.userCurriculumRates});

  static Curriculum fromJson(Map<String, Object> json) {
    print(json["CurriculumSchools"]);
    return Curriculum(
      id: json["id"] as String,
      name: json["name"] as String,
      point: json["point"] as int,
      parentCurriculum: json["ParentCurriculum"] == null
          ? null
          : Curriculum.parentfromjson(json["ParentCurriculum"]),
      // user: User.fromDictionary(json["User"]),
      curriculumSchools: json["CurriculumSchools"] == null
          ? null
          : (json["CurriculumSchools"] as List)
              .map<CurriculumSchool>((x) => CurriculumSchool.fromJson(x))
              .toList(),
      childCurriculums: json["ChildCurriculums"] == null
          ? null
          : (json["ChildCurriculums"] as List)
              .map<Curriculum>((x) => Curriculum.fromJson(x))
              .toList(),
      userCurriculumRates: json["UserCurriculumRate"] == null
          ? null
          : (json["UserCurriculumRate"] as List)
              .map<UserCurriculumRate>((x) => UserCurriculumRate.fromJson(x))
              .toList(),
    );
  }

  static Curriculum parentfromjson(Map<String, Object> json) {
    return Curriculum(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }

  @override
  String toString() {
    return 'Curriculum { id: $id, name: $name, point: $point, curriculumSchools: $curriculumSchools, childCurriculums: $childCurriculums, userCurriculumRates: $userCurriculumRates }';
  }
}
