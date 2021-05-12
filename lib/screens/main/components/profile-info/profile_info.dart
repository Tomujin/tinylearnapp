import 'package:flutter/material.dart';
import 'package:tiny/screens/main/components/profile-info/profile_photo.dart';

class ProfileInfo extends StatelessWidget {
  final String direction;
  final String profilePic;
  final double imageSize;
  final String role;
  final String userName;
  ProfileInfo(
      {this.direction,
      this.userName,
      this.profilePic,
      this.imageSize,
      this.role});
  @override
  Widget build(BuildContext context) {
    if (direction == "vertical")
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePhoto(
              imageSize: this.imageSize,
              profilePic: this.profilePic,
              role: this.role),
          SizedBox(width: 8),
          Text(
            userName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      );
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePhoto(
              imageSize: this.imageSize,
              profilePic: this.profilePic,
              role: this.role),
          SizedBox(height: 8),
          Text(
            userName.length > 12 ? userName.substring(0, 9) + "..." : userName,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      );
  }
}
