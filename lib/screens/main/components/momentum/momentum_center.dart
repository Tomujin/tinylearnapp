import 'dart:ffi';
import 'package:tiny/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MomentumCenter extends StatelessWidget {
  final String emoji;
  final String line1;
  final String line2;
  final double line1Font;
  final Widget widget;
  MomentumCenter(
      {this.emoji, this.line1, this.line2, this.line1Font, this.widget});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 307.w,
      height: 378.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: ligtGrey2,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 29.h),
          Text(emoji,
              style: TextStyle(
                fontSize: 60.h,
              )),
          Text(
            this.line1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightGreen,
              fontSize: this.line1Font ?? 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (line2 != null)
            Text(
              line2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: lightGreen,
                fontSize: line1Font != null ? 36 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          SizedBox(
            height: 16.h,
          ),
          this.widget,
        ],
      ),
    ));
  }
}
