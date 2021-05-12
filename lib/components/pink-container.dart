import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget pinkContainer({child, context, height, width}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/mainback.jpg"),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height ?? 36.h,
          width: width ?? 120.w,
          child: SvgPicture.asset(
            'assets/svg/tinybeta.svg',
            color: Colors.white,
          ),
        ),
        Container(
          child: child ?? Container(),
        )
      ],
    ),
  );
}
