import 'package:flutter/material.dart';
import 'package:tiny/components/grey100-appbar.dart';
import 'package:tiny/functions/pushToScreen.dart';
import 'package:tiny/screens/main/screens/create-content/select-target-screen.dart';
import 'package:tiny/theme/style.dart';

class CreateQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: grey100AppBar(
          title: 'Add practice question',
          doOnPress: () => pushToScreen(context, SelectTargetScreen())),
      body: Container(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: 300, minHeight: 300, minWidth: double.infinity),
              decoration: BoxDecoration(color: lightPurple),
              child: Center(
                  child: Text(
                'Click here to add question',
                style: TextStyle(color: Colors.white),
              )),
            ),
            SizedBox(
              height: 30,
            ),
            QuestionInput(),
            SizedBox(
              height: 12,
            ),
            QuestionInput(),
            SizedBox(
              height: 12,
            ),
            QuestionInput(),
            SizedBox(
              height: 12,
            ),
            QuestionInput(),
          ],
        ),
      ),
    );
  }
}

class QuestionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey[400], width: 1)),
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      padding: EdgeInsets.only(top: 10, left: 14, right: 10, bottom: 8),
      margin: EdgeInsets.only(left: 24, right: 24),
      child: Text('Add question'),
    );
  }
}
