import 'package:flutter/material.dart';
import 'package:tiny/screens/switch/switch-screen.dart';
import 'package:tiny/services/secure-storage.dart';
import 'package:tiny/screens/main/app-screen.dart';

class Onboarding extends StatelessWidget {
  final SecureStorage _secureStorage = new SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            elevation: 0,
          ),
        ),
        body: PageView(
          children: [
            Center(
              child: Text('Screen 1'),
            ),
            Center(
              child: Text('Screen 2'),
            ),
            Center(
              child: Text('Screen 3'),
            ),
            Center(
              child: Text('Screen 4'),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Screen 5'),
                FlatButton(
                  onPressed: () {
                    _secureStorage.setSecureStore('onboarded', 'true');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return SwitchScreen();
                    }));
                  },
                  child: Text("Let's begin!"),
                )
              ],
            )),
          ],
        ));
  }
}
