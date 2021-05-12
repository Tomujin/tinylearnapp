import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/resources/user-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/services/secure-storage.dart';

import 'package:tiny/theme/style.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key key}) : super(key: key);
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController =
      TextEditingController.fromValue(TextEditingValue.empty);
  final SecureStorage _secureStorage = new SecureStorage();
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  int selectedIndex = -1;
  String text = "Feedback";
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserRepository _userRepo = RepositoryProvider.of<UserRepository>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBackgroundImage),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 44.h),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/svg/tinybeta.svg",
                    color: Colors.white),
                SizedBox(
                  height: 44.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "WELCOME FEEDBACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 71.h,
                  width: 246.w,
                  child: Text(
                    "Та манай бүтээгдэхүүнтэй холбоотой сайжруулалт санал хүсэлтээ нээлттэй илгээгээрэй. Бид үргэлж сайжирч дараагийн version-оо таньд хүргэх болно.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                if (!_keyboardIsVisible())
                  CircleAvatar(
                    radius: 110.h,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        "https://s3-ap-southeast-1.amazonaws.com/tinyapp.ai/system_images/feedbackman.png"),
                  ),
              ],
            ),
            SizedBox(height: 42.h),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: ScreenUtil.defaultSize.width - 29.w,
                  height: 45.h,
                  padding: EdgeInsets.only(left: 20.w),
                  margin:
                      EdgeInsets.only(bottom: 31.h, left: 29.w, right: 29.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.h),
                    color: Color(0xccf1f1f2),
                  ),
                  child: TextField(
                    controller: _feedbackController,
                    decoration: InputDecoration(
                      hintText: "Send message",
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final userid =
                              await _secureStorage.getSecureStore("userId");
                          final rp = await _userRepo.createFeedback(
                              userid, _feedbackController.text);
                          if (rp) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: Text("Feedback"),
                                content: Text("Feedback recieved"),
                                actions: [
                                  CupertinoButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            );
                            _feedbackController.clear();
                            Navigator.of(context).pop();
                          }
                          // print("aaaa$rp");
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
