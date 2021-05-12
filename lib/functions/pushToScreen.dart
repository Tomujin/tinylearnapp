import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pushToScreen(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => widget),
  );
}
