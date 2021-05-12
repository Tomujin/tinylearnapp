import 'package:tiny/models/userMomentum.dart';

class MomentumItem {
  String id;
  String name;
  UserMomentum userMomentum;
  MomentumItem({this.id, this.name, this.userMomentum});

  static MomentumItem fromJson(Map<String, Object> json) {
    return MomentumItem(
        id: json["id"] as String,
        name: json["name"] as String,
        userMomentum: UserMomentum.fromJson(json["UserMomentum"]));
  }
}
