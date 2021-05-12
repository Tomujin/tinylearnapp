import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimingWidget extends StatefulWidget {
  // final Content content;

  const PrimingWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PrimingWidgetState();
  }
}

class _PrimingWidgetState extends State<PrimingWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey4,
      child: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 58.h),
              Image(
                width: 146.w,
                image: CachedNetworkImageProvider(
                    "https://s3-ap-southeast-1.amazonaws.com/tinyapp.ai/system_images/priming.jpg"),
              ),
              SizedBox(height: 16.h),
              Text(
                "5 MINUTE",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white),
              ),
              // SizedBox(height: 4),
              Text(
                "PRIMING",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.white),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 200.w,
                height: 40.h,
                child: RaisedButton(
                  color: Colors.white,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30)),
                  onPressed: () {},
                  child: Text(
                    'Tap to start',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              )
            ],
          )),
    );
  }
}
