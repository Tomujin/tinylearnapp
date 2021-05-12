import 'dart:ffi';
import 'package:tiny/models/models.dart';

class UserMomentum {
  String id;
  DateTime momentDay;
  User user;
  int madeCount;
  UserMomentum({this.id, this.momentDay, this.user, this.madeCount});
  static UserMomentum fromJson(Map<String, Object> json) {
    return UserMomentum(
        id: json["id"] as String,
        momentDay: json["momentDay"] as DateTime,
        user: User.fromJson(json["User"]),
        madeCount: json["madeCount"] as int);
  }
}
