import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container whiteButton(
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
    margin: EdgeInsets.only(left: left ?? 38.w, right: right ?? 38.w, top: 1),
    width: double.infinity,
    height: 50.h,
    child: ElevatedButton(
        child: Text(
          text ?? '',
          style: TextStyle(
            color: color ?? Color(0xff7851a2),
            fontSize: fontSize,
          ),
        ),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: doOnPress),
  );
}
