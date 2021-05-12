import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiny/screens/main/screens/onboarding/onboarding.dart';
import 'package:tiny/services/secure-storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:tiny/screens/switch/switch-screen.dart';
import 'package:tiny/theme/style.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage _secureStorage = new SecureStorage();
  bool _boarded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changePage();
    });
  }

  Future<void> changePage() async {
    bool onboarded = true; //await getTokens();
    setState(() {
      _boarded = onboarded;
    });

    await sleepOneSecond(); //For purposedly
    if (onboarded == false)
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return Onboarding();
      }));
  }

  Future<bool> getTokens() async {
    final onboarded = await _secureStorage.getSecureStore("onboarded");
    return onboarded == 'true';
  }

  Future sleepOneSecond() {
    return new Future.delayed(
        const Duration(seconds: 1, milliseconds: 500), () => "1.5");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (ctx, state) {
        if (state is AuthenticationNotAuthenticated && _boarded) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return SwitchScreen();
          }));
        }
        if (state is AuthenticationAuthenticated && _boarded) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            //  return SwitchScreen();
            return AppScreen(0);
          }));
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0,
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/tiny_logo.svg',
                  height: 108,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
