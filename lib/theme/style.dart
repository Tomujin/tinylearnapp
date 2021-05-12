import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: lightPurple, //Color(0xff7851a2),
    accentColor: Color(0xff7851a2),
    buttonTheme: ButtonThemeData(
        buttonColor: lightPurple, textTheme: ButtonTextTheme.primary),
    fontFamily: GoogleFonts.openSans().fontFamily,
    // canvasColor: Colors.transparent,
    // accentColor: Colors.orange,
    // hintColor: Colors.white,
    // dividerColor: Colors.white,
    // buttonColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    // canvasColor: Colors.black,
  );
}

const purple = Color(0xff7851A2);
const lightPurple = Color(0xffef508b);
const lightGreen = Color(0xff55c595);
const ligtGrey = Color(0xff8c8c8c);
const ligtGrey2 = Color(0xffc7c7cc);
const ligtGrey3 = Color(0xffe5e5ea);
const ligtGrey4 = Color(0xffDADADA);
const grey4 = Color(0xff96adb6);
const darkGrey = Color(0xff535353);
const dark = Color(0xff252525);
const mainSpace = 15.0;
const storyBorderRadius = 60.0;
const storySize = 60.0;
const inPostUserPictureSize = 25.0;
const mainBackgroundImage = "assets/images/mainback.jpg";
