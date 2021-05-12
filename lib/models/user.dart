import 'package:equatable/equatable.dart';
import 'package:tiny/models/user_follow.dart';
import 'package:tiny/models/user_social_network.dart';

class User extends Equatable {
  final String id;
  final String sub;
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String photo;
  final String bio;
  final User acceptedByUser;
  final List<UserFollow> userFollows;
  final List<UserSocialNetwork> userSocialNetwork;
  String profilePic;
  User(
      {this.id,
      this.sub,
      this.userName,
      this.lastName,
      this.firstName,
      this.email,
      this.profilePic,
      this.photo,
      this.bio,
      this.acceptedByUser,
      this.userFollows,
      this.userSocialNetwork});

  @override
  List<Object> get props => [
        id,
        sub,
        email,
        userName,
        firstName,
        profilePic,
        lastName,
        photo,
        acceptedByUser,
        userFollows,
        userSocialNetwork
      ];

  factory User.fromDictionary(Map<String, dynamic> json) {
    return json != null
        ? User(
            id: json['id'],
            sub: json['sub'],
            userName: json['userName'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            bio: json['bio'],
            email: json['email'],
            profilePic: json['profilePic'],
            acceptedByUser: User.fromDictionary(json['AcceptedByUser']),
            userFollows: json["UserFollow"] == null
                ? null
                : (json["UserFollow"] as List)
                    .map<UserFollow>((x) => UserFollow.fromJson(x))
                    .toList(),
            userSocialNetwork: json["UserSocialNetwork"] == null
                ? null
                : (json["UserSocialNetwork"] as List)
                    .map<UserSocialNetwork>(
                        (x) => UserSocialNetwork.fromJson(x))
                    .toList(),
          )
        : null;
  }
  Map toDictionary() {
    return {
      "id": this.id,
      "sub": this.sub,
      "email": this.email,
      "profilePic": this.profilePic,
      "userName": this.userName,
      "firstName": this.firstName,
      "userFollows": this.userFollows
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      id: json["id"] as String,
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      userName: json["userName"] as String,
      profilePic: json["profilePic"] as String,
      bio: json["bio"] as String,
      userFollows: json["UserFollow"] == null
          ? null
          : (json["UserFollow"] as List)
              .map<UserFollow>((x) => UserFollow.fromJson(x))
              .toList(),
    );
  }
}
