import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/components/pink-container.dart';
import 'package:tiny/components/white-button.dart';
import 'package:tiny/resources/authentication-repository.dart';
import 'package:tiny/screens/login/login-screen.dart';
import 'package:tiny/screens/signin/sigin-screen.dart';
import 'package:tiny/screens/signup/signup-screen.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onLoadStart(String url) async {
    print("\n\nStarted $url\n\n");
  }

  @override
  Future onLoadStop(String url) async {
    print("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(String url, int code, String message) {
    print("\n\nCan't load $url.. Error: $message\n\n");
  }

  @override
  void onExit() {
    print("\n\nBrowser closed!\n\n");
  }
}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback) : super(bFallback: browserFallback);

  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class SwitchScreen extends StatefulWidget {
  ChromeSafariBrowser browser = new MyChromeSafariBrowser(new MyInAppBrowser());
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    final authRepo = RepositoryProvider.of<AuthencationRepository>(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (ctx, state) {
        if (widget.browser.isOpened()) {
          widget.browser.close();
        }
      },
      child: Scaffold(
        body: pinkContainer(
            context: context,
            child: Column(
              children: [
                SizedBox(
                  height: 147.h,
                ),
                whiteButton(
                    text: 'Sign in',
                    doOnPress: () => {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return SignInScreen();
                            // return AppScreen(0);
                          }))
                        }),
                SizedBox(
                  height: 14.h,
                ),
                whiteButton(
                  text: 'Sign up',
                  doOnPress: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return SignUpScreen();
                      }),
                    ),
                  },
                ),
              ],
            )),
      ),

      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         RaisedButton(
      //           onPressed: () async {
      //             await widget.browser.open(
      //                 url: authRepo.authorizationUrl,
      //                 options: ChromeSafariBrowserClassOptions(
      //                     android: AndroidChromeCustomTabsOptions(
      //                         addDefaultShareMenuItem: false),
      //                     ios: IOSSafariOptions(
      //                         barCollapsingEnabled: false,
      //                         presentationStyle:
      //                             IOSUIModalPresentationStyle.FORM_SHEET)));
      //           },
      //           child: Text('Log In'),
      //         ),
      //         RaisedButton(
      //           onPressed: () async {
      //             await widget.browser.open(
      //                 url: authRepo.registrationUrl,
      //                 options: ChromeSafariBrowserClassOptions(
      //                     android: AndroidChromeCustomTabsOptions(
      //                         addDefaultShareMenuItem: false),
      //                     ios: IOSSafariOptions(
      //                         barCollapsingEnabled: false,
      //                         presentationStyle:
      //                             IOSUIModalPresentationStyle.FORM_SHEET)));
      //           },
      //           child: Text('Sign Up'),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
