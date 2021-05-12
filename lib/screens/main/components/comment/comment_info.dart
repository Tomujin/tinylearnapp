import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:tiny/theme/style.dart';

class CommentInfo extends StatelessWidget {
  final int reactionCount;
  // final Function addComment;
  // final String avatarUrl;
  // final String comment;
  // final DateTime timestamp;

  CommentInfo({
    this.reactionCount,
    // this.addComment,
    // this.avatarUrl,
    // this.comment,
    // this.timestamp
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "8h",
          style: TextStyle(fontSize: 10, color: ligtGrey),
        ),
        SizedBox(width: 10),
        Text(
          "10 likes",
          style: TextStyle(fontSize: 10, color: ligtGrey),
        ),
        SizedBox(width: 10),
        Text(
          "Reply",
          style: TextStyle(fontSize: 10, color: ligtGrey),
        ),
      ],
    );
  }
}
