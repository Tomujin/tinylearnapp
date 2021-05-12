import 'package:flutter/widgets.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:tiny/screens/splash/splash-screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => SplashScreen(),
  // "/login": (BuildContext context) => LoginScreen(),
  // "/signup": (BuildContext context) => SignUpScreen()
  "/app": (context) => AppScreen(0),
};
