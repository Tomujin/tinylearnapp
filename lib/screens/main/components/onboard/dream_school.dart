import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DreamSchoolWidget extends StatefulWidget {
  // final Content content;

  const DreamSchoolWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DreamSchoolWidgetState();
  }
}

class _DreamSchoolWidgetState extends State<DreamSchoolWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.all(25),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 27.h, bottom: 27.h),
                child: Center(
                  child: Text(
                    'YOUR DREAM SCHOOL',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ),
              Stack(
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                          padding: EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28.0.h,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "https://upload.wikimedia.org/wikipedia/en/thumb/b/b7/Stanford_University_seal_2003.svg/480px-Stanford_University_seal_2003.svg.png"),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28.0.h,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Container(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28.0.h,
                                      backgroundImage: CachedNetworkImageProvider(
                                          "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          )),
                    ],
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: false,
                      viewportFraction: 0.3,
                      aspectRatio: 2,
                      initialPage: 1,
                    ),
                  ),
                ],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Column(children: [
                  Container(
                    child: Text(
                      "Yeah",
                      style: TextStyle(),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
