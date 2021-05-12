import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TargetProgressWidget extends StatefulWidget {
  // final Content content;

  const TargetProgressWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _TargetProgressWidgetState();
  }
}

class _TargetProgressWidgetState extends State<TargetProgressWidget> {
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
            "Rank to your important topic",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            margin: EdgeInsets.only(top: 26),
            child: SfSliderTheme(
              data: SfSliderThemeData(
                thumbRadius: 6,
                thumbStrokeColor: Colors.white,
                thumbStrokeWidth: 1,
              ),
              child: SfSlider(
                min: 0.0,
                max: 100.0,
                value: 30.0,
                interval: 20,
                activeColor: lightGreen,
                inactiveColor: ligtGrey3,
                onChanged: (dynamic value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
