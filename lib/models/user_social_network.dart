import 'package:tiny/models/user.dart';

class UserSocialNetwork {
  String id;
  String userName;
  // User user;

  UserSocialNetwork({this.id, this.userName});

  static UserSocialNetwork fromJson(Map<String, Object> json) {
    return UserSocialNetwork(
      id: json["id"] as String,
      userName: json["userName"] as String,
      // user: User.fromDictionary(json["User"]),
    );
  }
}
