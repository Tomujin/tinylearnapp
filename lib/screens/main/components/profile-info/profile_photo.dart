import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiny/screens/main/components/profile-info/circle_photo.dart';
import 'package:tiny/screens/main/components/profile-info/role.dart';
import 'package:tiny/theme/style.dart';

class ProfilePhoto extends StatelessWidget {
  final String profilePic;
  final double imageSize;
  final String role;
  ProfilePhoto({this.profilePic, this.imageSize, this.role});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: this.imageSize,
        height: this.imageSize,
        child: Stack(children: <Widget>[
          // if (role != null)
          Container(
            padding: EdgeInsets.all(2),
            child: CirclePhoto(
              profilePic: this.profilePic,
              radius: imageSize / 2,
            ),
            // CircleAvatar(
            //   radius: (this.imageSize / 2),
            //   backgroundImage: CachedNetworkImageProvider(this.profilePic ??
            //       "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
            // ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(this.imageSize / 2 + 2),
                border:
                    Border.all(width: this.imageSize * 0.02, color: lightGreen),
                color: Colors.white),
          ),
          // else
          //   Container(
          //     padding: EdgeInsets.all(2),
          //     child: CircleAvatar(
          //       radius: (this.imageSize / 2),
          //       backgroundImage: CachedNetworkImageProvider(this.profilePic),
          //     ),
          //   ),
          // if (role != null)
          RolePhoto(
            imageSize: this.imageSize,
            role: this.role,
          )
        ]));
  }
}
