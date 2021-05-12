import 'package:flutter/material.dart';
import 'package:tiny/models/content.dart';

class ContentWidget extends StatefulWidget {
  final Content content;

  const ContentWidget({Key key, @required this.content}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState();
  }
}

class _ContentWidgetState extends State<ContentWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.content.sourcePath ??
          "https://media.istockphoto.com/vectors/abstract-square-white-background-geometric-minimalistic-cover-design-vector-id916617930?b=1&k=6&m=916617930&s=612x612&w=0&h=PSmxmODUAcfbscaM528CI9TMsvCxL8z44LekwPvawNw=",
      fit: BoxFit.contain,
    );
  }
}
