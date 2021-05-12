import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiny/screens/main/components/community/join_community.dart';
import 'package:tiny/screens/main/components/community/community_members.dart';
import 'package:tiny/screens/main/components/onboard/congrats.dart';
import 'package:tiny/screens/main/components/onboard/dream_school.dart';
import 'package:tiny/screens/main/components/onboard/target_exam.dart';
import 'package:tiny/screens/main/components/onboard/target_progress.dart';
import 'package:tiny/screens/main/components/priming/priming.dart';
import 'package:tiny/screens/main/screens/profile/bloc/profile_bloc.dart';
import 'package:tiny/theme/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../home/components/story.dart';
import '../home/components/postComponent.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/models/story.dart';
import 'package:tiny/models/storyContent.dart';
import 'package:tiny/utils/tiny_icons.dart';

const assetName = 'assets/svg/exercise.svg';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key key}) : super(key: key);

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  List<Post> posts;
  List<Story> stories;

  @override
  void initState() {
    super.initState();
    stories = [
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
      Story(
          publishedDate: DateTime.now(),
          user: User(
              bio: "Bio",
              sub: "sub",
              userName: "userName",
              firstName: "firstName",
              lastName: "lastaName",
              email: "email",
              photo:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
              profilePic:
                  "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          storyContent: [
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
            StoryContent(
                user: User(
                    bio: "Bio",
                    sub: "sub",
                    userName: "userName",
                    firstName: "firstName",
                    lastName: "lastaName",
                    email: "email",
                    photo:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                    profilePic:
                        "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
                mediaType: "Image",
                sourcePath:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"),
          ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: SvgPicture.asset(
            assetName,
            color: ligtGrey,
          ),
          padding: EdgeInsets.only(left: mainSpace, top: 5, right: mainSpace),
        ),
        leadingWidth: 100,
        title: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(bottom: 34),
                  decoration: BoxDecoration(
                      border: Border.all(color: ligtGrey),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Text(
                    'Dialy progress',
                    style: GoogleFonts.openSans(
                        color: ligtGrey,
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                  )),
              Container(
                margin: EdgeInsets.only(top: 26),
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    thumbRadius: 6,
                    thumbStrokeColor: Colors.white,
                    thumbStrokeWidth: 1,
                  ),
                  child: SfSlider(
                    min: 0.0,
                    max: 100.0,
                    value: 30.0,
                    interval: 20,
                    activeColor: lightGreen,
                    inactiveColor: ligtGrey3,
                    onChanged: (dynamic value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 8.0, // Spacing for title
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.all(14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            padding: EdgeInsets.only(right: 15.w, left: 12.w),
            child: Text(
              "beta",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          )
        ],

        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocProvider<ProfileBloc>(
        create: (BuildContext context) {
          pBloc.add(LoadProfileEvent());
          return pBloc;
        },
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (BuildContext ctx, state) {
            return Column(
              children: [
                StoryScreen(
                    // stories: stories,
                    ),
                Divider(),
                Column(children: [
                  if (state is ProfileLoadState)
                    CongratsWidget(user: state.user),
                  JoinCommunityWidget(),
                  MembersWidget(),
                  DreamSchoolWidget(),
                  Divider(
                    color: grey4,
                    height: 0,
                  ),
                  TargetExamWidget(),
                  Divider(
                    height: 0,
                    color: grey4,
                  ),
                  PrimingWidget(),
                  Divider(
                    height: 0,
                    color: grey4,
                  ),
                  TargetProgressWidget(),
                  Container(
                    height: 8,
                    width: double.infinity,
                    color: ligtGrey4,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        infoRow(),
                        AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                                child: Image(
                              image: NetworkImage(
                                  "https://media-exp1.licdn.com/dms/image/C4E1BAQGYYNoN6t1Mtg/company-background_10000/0?e=2159024400&v=beta&t=TVJcOVHDNqTOLPwd_NGGUC82q555QwWHKtVOUN_Mg1w"),
                            ))),
                        userInfoRow(),
                      ],
                    ),
                  ),
                ]),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "What is Lorem Ipsum?",
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum ...",
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(48, 26, 48, 32),
                        child: Column(
                          children: [
                            FlatButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.radio_button_off_outlined,
                                      color: Colors.black54),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "1120",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ligtGrey),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                  borderRadius: new BorderRadius.circular(16)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.radio_button_off_outlined,
                                      color: Colors.black54),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "1120",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ligtGrey),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                  borderRadius: new BorderRadius.circular(16)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.radio_button_off_outlined,
                                      color: Colors.black54),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "1120",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ligtGrey),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                  borderRadius: new BorderRadius.circular(16)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.radio_button_off_outlined,
                                      color: Colors.black54),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "1120",
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: ligtGrey),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                  borderRadius: new BorderRadius.circular(16)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              width: double.infinity,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30)),
                                onPressed: () {},
                                child: Text('Confirm',
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Row userInfoRow() {
    return Row(
      children: [
        SizedBox(width: mainSpace),
        ClipRRect(
          child: Image.network(
            "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
            fit: BoxFit.cover,
            width: inPostUserPictureSize,
            height: inPostUserPictureSize,
          ),
          borderRadius: BorderRadius.circular(inPostUserPictureSize),
        ),
        SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black),
            ),
            Text(
              "Harvard ph.D",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFF777777)),
            ),
            Text(
              "Good Mother",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0xFF777777)),
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Icon(Tiny.clap, color: Colors.black54),
        SizedBox(width: 10.0),
        Icon(Tiny.clap, color: Colors.black54),
        SizedBox(width: 10.0),
        Icon(Tiny.disagree, color: Colors.black54),
        SizedBox(width: mainSpace),
      ],
    );
  }

  Row infoRow() {
    return Row(
      children: [
        SizedBox(width: mainSpace),
        Container(
          alignment: Alignment.center,
          height: 48,
          width: 48,
          child: Text("SAT",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              )),
          decoration: BoxDecoration(
              color: Color(0xFFc4c4c4),
              border: Border.all(
                color: Color(0xFFc4c4c4),
              ),
              borderRadius: BorderRadius.all(Radius.circular(48))),
        ),
        SizedBox(width: mainSpace),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SAT PHYSICS",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: darkGrey)),
            Text("Waves And Optics",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.grey)),
          ],
        ),
        Expanded(child: SizedBox()),
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}
