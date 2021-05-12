import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny/screens/main/components/comment/comment_info.dart';
import 'package:tiny/screens/main/components/profile-info/circle_photo.dart';
import 'package:tiny/screens/main/components/profile-info/profile_photo.dart';

class CommentUnit extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final DateTime timestamp;

  CommentUnit(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory CommentUnit.fromDocument(Map<String, Object> document) {
    return CommentUnit(
      username: document['username'],
      userId: document['userId'],
      comment: document["comment"],
      timestamp: document["timestamp"],
      avatarUrl: document["avatarUrl"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CirclePhoto(profilePic: avatarUrl, radius: 15),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Text(
                    //   username,
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    // ),

                    SizedBox(
                      width: 340,
                      child: RichText(
                        text: TextSpan(
                            text: username,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black),
                            children: [
                              TextSpan(text: " "),
                              TextSpan(
                                text: comment,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    // color: Colors.black87,
                                    letterSpacing: 0),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                CommentInfo(
                  reactionCount: 4,
                ),
              ],
            ),
            Text("♡")
          ],
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
