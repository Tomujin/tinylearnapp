import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/components/pink-container.dart';
import 'package:tiny/components/white-button.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:tiny/screens/signin/sigin-screen.dart';

import 'package:tiny/theme/style.dart';

class ApplyScreen extends StatefulWidget {
  ApplyScreen({Key key}) : super(key: key);
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  // return !(MediaQuery.of(context).viewInsets.bottom == 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pinkContainer(
        context: context,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(4),
              height: 183.h,
              width: 246.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      "https://s3-ap-southeast-1.amazonaws.com/tinyapp.ai/system_images/greenwomen.png"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 67.w, right: 67.w),
              // height: 71.h,
              width: 233.w,
              child: Text(
                "HELLO \nI’M TINY",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 67.w, right: 67.w),
              child: Image(image: AssetImage('assets/images/slogan.png')),
            ),
            SizedBox(
              height: 23.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 67.w, right: 67.w),
              height: 71.h,
              width: 233.w,
              child: Text(
                "A social media platform for learners. Roadmap to your dream school. Join our community of learners.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: 44.h,
            ),
            whiteButton(
              text: "Start apply",
              left: 88,
              right: 88,
              doOnPress: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) {
                    return SignInScreen();
                  }),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
