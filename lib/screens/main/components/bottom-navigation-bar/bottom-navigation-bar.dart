import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar(
      {Key key, this.updateTabSelection, this.selectedIndex = 0, this.routes})
      : super(key: key);

  final Function updateTabSelection;
  final int selectedIndex;
  final List routes;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = ScreenUtil().bottomBarHeight;
    return SizedBox(
      height: 70 + bottomPadding,
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: const Color(0xFF9AA6C9),
            //     spreadRadius: -50,
            //     blurRadius: 50,
            //   ),
            // ],
          ),
          child: Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(bottom: bottomPadding),
              child: Row(
                children: <Widget>[
                  ...routes
                      .map(
                        (route) => route == null
                            ? SizedBox(
                                width: 50.0,
                              )
                            : Expanded(
                                child: FlatButton(
                                onPressed: () {
                                  updateTabSelection(
                                      route['index'], route['text']);
                                },
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  route['icon'],
                                  color: route != null &&
                                          selectedIndex == route['index']
                                      ? Theme.of(context).accentColor
                                      : Colors.grey.shade400,
                                ),
                              )),
                      )
                      .toList()
                ],
              ),
            ),
          )),
    );
  }
}
