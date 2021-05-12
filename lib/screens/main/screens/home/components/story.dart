import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/models/story.dart';
import 'package:tiny/models/storyContent.dart';
import 'package:tiny/screens/main/components/profile-info/circle_photo.dart';
import 'package:tiny/screens/main/screens/home/blocs/story/story_bloc.dart';
import 'package:tiny/screens/main/screens/home/components/story_content.dart';
import 'package:tiny/theme/style.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({Key key}) : super(key: key);
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<StoryScreen> {
  StoryBloc _storyBloc;

  @override
  void initState() {
    super.initState();
    _storyBloc = context.read<StoryBloc>();
    _storyBloc.add(StoryFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.only(left: mainSpace, right: mainSpace, top: mainSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                height: 96,
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (BuildContext ctx, stateAuth) {
                  return BlocBuilder<StoryBloc, StoryState>(
                    builder: (context, state) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.stories.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0 &&
                                stateAuth is AuthenticationAuthenticated) {
                              return UserInStory(
                                  profilePic: stateAuth.user.profilePic);
                            } else
                              return StoryItem(
                                  isChallenge: index % 2 == 0,
                                  disabled: false,
                                  story: state.stories[index]);
                          });
                    },
                  );
                }),
                padding: EdgeInsets.only(bottom: mainSpace))
          ],
        ));
  }
}

class UserInStory extends StatelessWidget {
  final String profilePic;

  const UserInStory({Key key, this.profilePic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: CirclePhoto(
                    profilePic: this.profilePic,
                    radius: storySize / 2,
                  ),
                  width: storySize,
                  height: storySize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(storyBorderRadius),
                    color: Colors.black12,
                  ),
                ),
                // Positioned(
                //   child: Container(
                //     width: 20,
                //     height: 20,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(storyBorderRadius),
                //       color: lightPurple,
                //     ),
                //     alignment: Alignment.center,
                //     child: Icon(
                //       Icons.add,
                //       color: Colors.white,
                //       size: 15,
                //     ),
                //   ),
                //   bottom: -6,
                //   right: -6,
                // ),
                Positioned(
                  bottom: -20,
                  child: Container(
                      width: storySize,
                      alignment: Alignment.center,
                      child: Text('You', style: TextStyle(fontSize: 12))),
                )
              ],
              // overflow: Overflow.visible,
            ),
          ],
        ));
  }
}

class StoryItem extends StatelessWidget {
  final bool isChallenge;
  final bool disabled;
  final Story story;
  StoryItem({this.isChallenge, this.disabled, this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => StoryContentScreen(
                            storyContents: [
                              new StoryContent(mediaType: "Buddy"),
                              new StoryContent(mediaType: "Gratitude"),
                              new StoryContent(mediaType: "Streak"),
                              new StoryContent(mediaType: "Badge"),
                            ], //story.storyContent,
                            user: story.user,
                          )),
                );
              },
              child: Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(story.user.profilePic == null
                      ? "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg"
                      : story.user.profilePic),
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(storyBorderRadius / 2 + 2),
                  color: Colors.black12,
                ),
              ),
            ),
            width: storySize,
            height: storySize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(storyBorderRadius),
              border: Border.all(
                  width: 2,
                  color: disabled
                      ? Colors.black12
                      : Theme.of(context).accentColor),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
                width: storySize,
                alignment: Alignment.center,
                child: Text(
                  story.user.userName ?? '--',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                )),
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
