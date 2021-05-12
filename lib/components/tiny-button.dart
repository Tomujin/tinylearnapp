import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';

Container tinyButton(
    {String text,
    Function doOnPress,
    Color color,
    double left,
    double right,
    double fontSize}) {
  return Container(
    decoration: BoxDecoration(
        // color: Colors.white,
        ),
    margin: EdgeInsets.only(left: left ?? 65.w, right: right ?? 65.w, top: 1),
    width: double.infinity,
    height: 50.h,
    child: ElevatedButton(
        child: Text(
          text ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(purple)),
        onPressed: doOnPress),
  );
}
