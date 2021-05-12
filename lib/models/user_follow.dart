import 'package:equatable/equatable.dart';

class UserFollow extends Equatable {
  final String id;
  final String userId;
  final String followId;
  final bool isBuddy;
  final bool isFollow;
  final int followerCount;
  final int followingCount;
  final int buddyCount;
  final DateTime followDate;
  UserFollow(
      {this.id,
      this.userId,
      this.followId,
      this.followDate,
      this.isFollow,
      this.isBuddy,
      this.followerCount,
      this.followingCount,
      this.buddyCount});

  @override
  List<Object> get props => [
        id,
        userId,
        followId,
        followDate,
        isBuddy,
        isFollow,
        followerCount,
        followingCount,
        buddyCount
      ];

  static UserFollow fromJson(Map<String, Object> json) {
    return UserFollow(
      id: json["id"] as String,
      userId: json["userId"] as String,
      followId: json["followId"] as String,
      followDate: json["followDate"] as DateTime,
      isFollow: json["isFollow"] as bool,
      isBuddy: json["isBuddy"] as bool,
      followerCount: json["followerCount"] as int,
      followingCount: json["followingCount"] as int,
      buddyCount: json["buddyCount"] as int,
    );
  }
}
