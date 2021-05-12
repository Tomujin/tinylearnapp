import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinCommunityWidget extends StatefulWidget {
  // final Content content;

  const JoinCommunityWidget({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _JoinCommunityWidgetState();
  }
}

class _JoinCommunityWidgetState extends State<JoinCommunityWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.h,
      height: 325.h,
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        border: Border.all(
          color: Color.fromRGBO(229, 229, 234, 1),
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              // Column(children: [
              //   Padding(
              //     padding: EdgeInsets.all(12),
              //     child: Container(
              //       child: CircleAvatar(
              //         backgroundColor: Colors.white,
              //         radius: 48.0.h,
              //         backgroundImage: CachedNetworkImageProvider(
              //             "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
              //       ),
              //     ),
              //   ),
              // ]),
              Container(
                margin: EdgeInsets.only(top: 27.h, bottom: 27.h),
                child: Center(
                  child: Text(
                    'Join community',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ),

              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 1,
                        color: ligtGrey2,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        height: 1,
                        color: ligtGrey2,
                      ),
                    ],
                  ),
                  CarouselSlider(
                    items: [
                      Container(
                          padding: EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Text("Community",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14)),
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
                              Text("Personal",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14)),
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
                              Text("Tiny",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14)),
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
                      "Done",
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
