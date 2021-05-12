import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';

Container whiteCenter({child, context, height, width, title}) {
  return Container(
    width: 330.w,
    height: height ?? 400.h,
    margin: EdgeInsets.only(top: 33.h),
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
        SizedBox(height: 39.h),
        if (title != null)
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        child
      ],
    ),
  );
}
