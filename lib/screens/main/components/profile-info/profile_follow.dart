import 'package:flutter/material.dart';
import 'package:tiny/screens/main/components/profile-info/profile_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';

class ProfileFollow extends StatelessWidget {
  final String direction;
  final String profilePic;
  final double imageSize;
  final String role;
  final String userName;
  ProfileFollow(
      {this.direction,
      this.userName,
      this.profilePic,
      this.imageSize,
      this.role});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86.w,
      height: 124.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Color(0xffe5e5ea), width: 1, ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 9.h,
          ),
          ProfileInfo(
              userName: this.userName,
              profilePic: this.profilePic,
              imageSize: this.imageSize,
              role: this.role),
          Container(
            width: 60.w,
            height: 20.h,
            margin: EdgeInsets.all(5.h),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(lightGreen),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: Text(
                "Follow",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
