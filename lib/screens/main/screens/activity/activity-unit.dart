import 'package:flutter/material.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/screens/main/components/profile-info/profile_photo.dart';

class ActivityUnitScreen extends StatelessWidget {
  final User user;

  final Function onPressed;

  ActivityUnitScreen({this.user, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        ProfilePhoto(
          profilePic: this.user.profilePic,
          imageSize: 40,
        ),
        SizedBox(width: 8),
        Text(
          this.user.userName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text("accept user?"),
        SizedBox(width: 8),
        Spacer(),
        RaisedButton(
          onPressed: this.onPressed,
          child: Text("Accept"),
        )
      ]),
    );
  }
}
