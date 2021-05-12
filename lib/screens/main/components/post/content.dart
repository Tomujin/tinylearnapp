import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny/models/content.dart';
import 'package:tiny/screens/main/components/assessment/assessment.dart';
import 'package:tiny/screens/main/components/video-player/video-player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContentWidget extends StatefulWidget {
  final Content content;

  const ContentWidget({Key key, @required this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState();
  }
}

class _ContentWidgetState extends State<ContentWidget> {
  OverlayEntry entry;
  Duration timeout = const Duration(seconds: 1);

  startTimeout() {
    return new Timer(timeout, removeEntry);
  }

  void removeEntry() {
    Navigator.of(context).pop();

    entry?.remove();
  }

  // void showAssessment(BuildContext context) {
  //   print("aaaaa----aaaaaa3");
  // OverlayState overlayState = Overlay.of(context);
  // OverlayEntry overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //         top: 100,
  //         right: 0,
  //         left: 0,
  //         child: Assessment(
  //           post: widget.content.post,
  //           onAnswered: startTimeout,
  //         )));

  // overlayState.insert(overlayEntry);
  // setState(() {
  //   entry = overlayEntry;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;

    switch (widget.content.mediaType) {
      case "Image":
        contentWidget = Image(
          image: NetworkImage(widget.content.sourcePath),
        );
        break;
      case "Text":
        contentWidget = Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(239, 80, 139, 1),
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: NetworkImage(
          //           "https://media.istockphoto.com/vectors/abstract-square-white-background-geometric-minimalistic-cover-design-vector-id916617930?b=1&k=6&m=916617930&s=612x612&w=0&h=PSmxmODUAcfbscaM528CI9TMsvCxL8z44LekwPvawNw="),
          //       fit: BoxFit.cover),
          // ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.content.contentText ?? widget.content.post.postType,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
        break;
      case "Video":
        contentWidget = Container(
          child: TinyVideoPlayer(videoPath: widget.content.sourcePath),
        );
        break;
      default:
        contentWidget = Container();
        break;
    }

    return VisibilityDetector(
      key: Key(widget.content.id),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        print(
            'Widget ${visibilityInfo.key} is $visiblePercentage% visible content ${widget.content.id}');
        if (widget.content.post.postType == "Assessment" &&
            widget.content.userAnswer == null &&
            visiblePercentage == 100) {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => Assessment(
                  post: widget.content.post,
                  onAnswered: () => {
                        startTimeout(),
                      })));

          //showAssessment(context);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: ScreenUtil().screenHeight,
        child: contentWidget,
      ),
    );
  }
}
