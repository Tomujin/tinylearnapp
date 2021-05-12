import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny/components/touch-indicator/touch-indicator.dart';
import 'package:tiny/screens/main/components/bottom-navigation-bar/bottom-navigation-bar.dart';
import 'package:tiny/screens/main/routes.dart';
import 'package:tiny/screens/main/screens/create-content/create-screen.dart';
import '../../resources/user-repository.dart';

class AppScreen extends StatefulWidget {
  final int selectedIndex;
  AppScreen(this.selectedIndex);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  String text = "Home";

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  pushToScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CreateScreen()),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: new Container(
            height: 220.h,
            width: 375.w,
            padding: EdgeInsets.symmetric(horizontal: 37, vertical: 35),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                )),
            child: Column(
              children: [
                FlatButton(
                  onPressed: () async {
                    pushToScreen(context);
                    // final picker = ImagePicker();
                    // await picker
                    //     .getImage(source: ImageSource.gallery)
                    //     .then((file) async {
                    //   File editedFile;Zaya_1231
                    //   if (file != null)
                    //     File editedFile = await Navigator.of(context)
                    //         .push(new MaterialPageRoute(
                    //             builder: (context) => StoryDesigner(
                    //                   filePath: file.path,
                    //                 )));

                    //   // ------- you have editedFile

                    //   if (editedFile != null) {
                    //     print('editedFile: ' + editedFile.path);
                    //   }
                    //   Navigator.of(context).pop();
                    // });
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Color(0xFFDADADA)),
                      color: Color(0xFFF8F8F9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "Start Creator",
                            style: GoogleFonts.openSans(
                                fontSize: 16.ssp,
                                color: Color(0xFF8C8C8C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                  onPressed: () async {
                    pushToScreen(context);
                    // final picker = ImagePicker();
                    // await picker
                    //     .getImage(source: ImageSource.gallery)
                    //     .then((file) async {
                    //   File editedFile;
                    //   if (file != null)
                    //     File editedFile = await Navigator.of(context)
                    //         .push(new MaterialPageRoute(
                    //             builder: (context) => StoryDesigner(
                    //                   filePath: file.path,
                    //                 )));

                    //   // ------- you have editedFile

                    //   if (editedFile != null) {
                    //     print('editedFile: ' + editedFile.path);
                    //   }
                    //   Navigator.of(context).pop();
                    // });
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Color(0xFFDADADA)),
                      color: Color(0xFFF8F8F9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "Start Learner",
                            style: GoogleFonts.openSans(
                                fontSize: 16.ssp,
                                color: Color(0xFF8C8C8C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FlatButton(
                  onPressed: () async {
                    pushToScreen(context);
                    // final picker = ImagePicker();
                    // await picker
                    //     .getImage(source: ImageSource.gallery)
                    //     .then((file) async {
                    //   File editedFile;
                    //   if (file != null)
                    //     File editedFile = await Navigator.of(context)
                    //         .push(new MaterialPageRoute(
                    //             builder: (context) => StoryDesigner(
                    //                   filePath: file.path,
                    //                 )));

                    //   // ------- you have editedFile

                    //   if (editedFile != null) {
                    //     print('editedFile: ' + editedFile.path);
                    //   }
                    //   Navigator.of(context).pop();
                    // });
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: Color(0xFFDADADA)),
                      color: Color(0xFFF8F8F9),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "Start tiny user",
                            style: GoogleFonts.openSans(
                                fontSize: 16.ssp,
                                color: Color(0xFF8C8C8C),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserRepository _userRepo = RepositoryProvider.of<UserRepository>(context);
    return TouchIndicator(
      child: Scaffold(
          key: _scaffoldKey,
          body: RepositoryProvider(
            create: (context) {
              return _userRepo;
            },
            lazy: true,
            child: Stack(children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: routes.firstWhere(
                        (route) =>
                            route != null && route['index'] == selectedIndex,
                        orElse: () => null)["screen"],
                    padding: EdgeInsets.only(bottom: 70.h),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: MyBottomNavigationBar(
                        updateTabSelection: updateTabSelection,
                        routes: routes,
                        selectedIndex: selectedIndex),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 41.0.h,
                      width: 41.0.h,
                      margin: EdgeInsets.only(bottom: 35.h),
                      child: FittedBox(
                          child: FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        mini: false,
                        onPressed: showBottomSheet,
                        tooltip: "Create",
                        child: Container(
                          margin: EdgeInsets.all(15.0.h),
                          child: SvgPicture.asset("assets/svg/plus.svg"),
                        ),
                        elevation: 4.0,
                      )),
                      padding: EdgeInsets.only(bottom: 5.h),
                    ),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
