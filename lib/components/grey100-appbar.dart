import 'package:flutter/material.dart';
import 'package:tiny/theme/style.dart';

AppBar grey100AppBar({String title, doOnPress}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black87),
    ),
    backgroundColor: Colors.grey[100],
    elevation: 0,
    actions: [
      if (doOnPress != null)
        FlatButton(
          child: Text(
            'Next',
            style: TextStyle(color: lightPurple),
          ),
          onPressed: () => {doOnPress()},
        )
    ],
  );
}
