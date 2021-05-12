import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TargetExamWidget extends StatefulWidget {
  // final Content content;

  const TargetExamWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TargetExamWidgetState();
  }
}

class _TargetExamWidgetState extends State<TargetExamWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.8,
      // decoration: BoxDecoration(*
      //   color: Theme.of(context).accentColor,
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "YOUR TARGET EXAM",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          ButtonTheme(
            minWidth: 300.0.w,
            height: 67.h,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              // side: BorderSide(color: Colors.red)),
              onPressed: () {},
              child: Text(
                "SAT SUBJECT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ligtGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          ButtonTheme(
            minWidth: 300.0.w,
            height: 67.h,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              // side: BorderSide(color: Colors.red)),
              onPressed: () {},
              child: Text(
                "SAT REASON",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ligtGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          ButtonTheme(
            minWidth: 300.0.w,
            height: 67.h,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              // side: BorderSide(color: Colors.red)),
              onPressed: () {},
              child: Text(
                "TOEFL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ligtGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
