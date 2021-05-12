import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiny/models/user.dart';
// import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';

class CongratsWidget extends StatelessWidget {
  // final Content content;
  final User user;
//   const CongratsWidget({Key key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return _CongratsWidgetState();
//   }
// }

// class _CongratsWidgetState extends State<CongratsWidget> {
  // int pageViewActiveIndex = 0;

  CongratsWidget({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 500.h,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 88.h,
          ),
          Container(
            width: 102.h,
            height: 102.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5,
              ),
            ),
            child: Align(
                child: SvgPicture.asset(
              'assets/svg/profile2.svg',
              height: 69.h,
              width: 68.h,
            )),
          ),
          SizedBox(
            height: 22.h,
          ),
          Text(
            "CONGRATS!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              // fontFamily: "Open Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "@${this.user.userName}",
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 49.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: CircleAvatar(
                  radius: 30.0.h,
                  backgroundImage: CachedNetworkImageProvider(this
                          .user
                          .profilePic ??
                      "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Accepted by:",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    Text(
                      "@${this.user.acceptedByUser.userName}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 36.h,
          ),
          RotationTransition(
            turns: AlwaysStoppedAnimation(0.25),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          Text("Swipe up", style: TextStyle(color: Colors.white))
        ],
      ),
      // ),
    );
  }
}
