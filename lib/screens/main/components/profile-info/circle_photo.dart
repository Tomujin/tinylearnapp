import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CirclePhoto extends StatelessWidget {
  final String profilePic;
  final double radius;
  CirclePhoto({this.profilePic, this.radius});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: (this.radius),
      backgroundImage: CachedNetworkImageProvider(this.profilePic ??
          "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
    );
  }
}
