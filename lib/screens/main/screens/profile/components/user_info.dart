import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/screens/main/screens/profile/components/edit_profile_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../profile-other.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key key, this.isMe, this.user, this.role, this.onTap})
      : super(key: key);
  final User user;
  final String role;
  final bool isMe;
  final VoidCallback onTap;
  pushToScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => EditProfilePage(
                user: this.user,
              )),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        child: CircleAvatar(
                          radius: 32.0.h,
                          backgroundImage: NetworkImage(this.user.profilePic ??
                              "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                              width: 2, color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(width: 2, color: lightGreen),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text("Active learning",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w300,
                                  color: ligtGrey,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(width: 2, color: ligtGrey3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Change user name",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: ligtGrey,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(),
                    controller: TextEditingController(text: this.user.userName),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: ligtGrey3,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Update your bio",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: ligtGrey,
                        fontSize: 12),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                    ),
                    minLines: 1,
                    maxLines: 5,
                    controller: TextEditingController(text: this.user.bio),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: ligtGrey3,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Column(children: [
                      Container(
                        child: Text(
                          "Done",
                          style: GoogleFonts.openSans(),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ]),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      _authBloc.add(UserLoggedOut());
                    },
                    child: Column(children: [
                      Container(
                        child: Text(
                          "Log Out",
                          style: GoogleFonts.openSans(),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showEditBadgeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 48.0.h,
                          backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
                        ),
                      ),
                    ),
                  ]),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 1,
                            color: ligtGrey2,
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Container(
                            height: 1,
                            color: ligtGrey2,
                          ),
                        ],
                      ),
                      CarouselSlider(
                        items: [
                          Container(
                              padding: EdgeInsets.only(top: 6),
                              child: Column(
                                children: [
                                  Text("Community",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14)),
                                  Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Container(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 28.0.h,
                                          backgroundImage: NetworkImage(
                                              "https://upload.wikimedia.org/wikipedia/en/thumb/b/b7/Stanford_University_seal_2003.svg/480px-Stanford_University_seal_2003.svg.png"),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 6),
                              child: Column(
                                children: [
                                  Text("Personal",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14)),
                                  Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Container(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 28.0.h,
                                          backgroundImage: NetworkImage(
                                              "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.only(top: 6),
                              child: Column(
                                children: [
                                  Text("Tiny",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 14)),
                                  Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Container(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 28.0.h,
                                          backgroundImage: NetworkImage(
                                              "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png"),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              )),
                        ],
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: false,
                          viewportFraction: 0.5,
                          aspectRatio: 2.0,
                          initialPage: 1,
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Column(children: [
                      Container(
                        child: Text(
                          "Done",
                          style: GoogleFonts.openSans(),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      // margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(height: 16.h),
              Column(children: [
                InkWell(
                  onTap: () {
                    _showEditProfileDialog(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: CircleAvatar(
                        radius: 40.0.h,
                        backgroundImage: NetworkImage(user.profilePic ??
                            "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(width: 2, color: lightGreen),
                      ),
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      statusInfo(
                          user.userFollows.length != 0
                              ? user.userFollows[0].followerCount
                              : 0,
                          "Following"),
                      statusInfo(
                          user.userFollows.length != 0
                              ? user.userFollows[0].followingCount
                              : 0,
                          "Followers"),
                      statusInfo(
                          user.userFollows.length != 0
                              ? user.userFollows[0].buddyCount
                              : 0,
                          "Buddies"),
                    ],
                  ),
                ),
              ),
              /*Spacer(),
              IconButton(
                icon: Icon(
                  Icons.switch_account,
                ),
                onPressed: () => this.onTap(),
              ),*/
              // SizedBox(width: 40)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  _showEditProfileDialog(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName}",
                        style: GoogleFonts.openSans(
                          color: Color(0xFF252525),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Text("$role",
                      //     style: GoogleFonts.openSans(
                      //         fontSize: 12, color: Colors.black)),
                      Text("${user.bio ?? " "}",
                          style: GoogleFonts.openSans(
                              fontSize: 12, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  _showEditBadgeDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        "Your Badge",
                        style: TextStyle(fontSize: 10, color: ligtGrey),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Container(
                          height: 64.0.h,
                          width: 64.h,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showEditBadgeDialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        "Member of",
                        style: GoogleFonts.openSans(
                          fontSize: 10,
                          color: ligtGrey,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        child: Container(
                          height: 64.0.h,
                          width: 64.h,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://upload.wikimedia.org/wikipedia/en/thumb/b/b7/Stanford_University_seal_2003.svg/480px-Stanford_University_seal_2003.svg.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => ProfileOther()));
                  },
                  child: Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 18.0.h,
                          backgroundImage: NetworkImage(user
                                  .acceptedByUser.profilePic ??
                              "https://www.travelcontinuously.com/wp-content/uploads/2018/04/empty-avatar.png"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Accepted by:",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            Text(
                              "@${user.acceptedByUser.userName ?? "tiny"}",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                  color: ligtGrey,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              user.userSocialNetwork != null
                  ? Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              "assets/svg/instagram.svg",
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "@${user.userSocialNetwork[0].userName}",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w400,
                                color: ligtGrey,
                                fontSize: 12),
                          )
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 16.h,
                    )
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffdbdbdb),
                ),
                borderRadius: BorderRadius.all(Radius.circular(1))),
          ),
          isMe
              ? Container()
              // ? InkWell(
              //     onTap: () {
              //       // pushToScreen(context);
              //       print("Click event on Container");
              //     },
              //     child: Container(
              //       // width: double.infinity,
              //       alignment: Alignment.center,
              //       margin: EdgeInsets.only(top: 18.0.h),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Color.fromRGBO(120, 81, 162, 1),
              //           width: 1,
              //         ),
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           'Edit Profile',
              //           style: TextStyle(
              //               color: Color.fromRGBO(120, 81, 162, 1),
              //               fontWeight: FontWeight.normal,
              //               fontSize: 14,
              //               height: 1),
              //         ),
              //       ),
              //     ),
              //   )
              : Container(
                  margin: EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {},
                          child: Column(children: [
                            Container(
                              child: Text(
                                "Follow",
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              padding: EdgeInsets.all(4),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: ligtGrey4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: ligtGrey4)),
                          onPressed: () {},
                          child: Column(children: [
                            Container(
                              child: Text(
                                "Message",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xFF616770)),
                              ),
                              padding: EdgeInsets.all(4),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 32,
                        child: RaisedButton(
                          padding: EdgeInsets.zero,
                          color: ligtGrey4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              side: BorderSide(color: ligtGrey4)),
                          onPressed: () {},
                          child: Column(children: [
                            Container(
                              child: Icon(Icons.keyboard_arrow_down,
                                  color: Color(0xFF616770)),
                              padding: EdgeInsets.all(4),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 12.h),
        ],
      ),
      // ),
    );
  }

  Widget statusInfo(status, title) {
    return Column(
      children: [
        Column(
          children: <Widget>[
            Text(
              "$status",
              style: GoogleFonts.openSans(
                color: Color(0xFF616161),
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 2),
            Text(
              title,
              style: GoogleFonts.openSans(
                color: Color(0xFF616161),
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
