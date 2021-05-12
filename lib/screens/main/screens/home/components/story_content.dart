import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiny/models/storyContent.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/screens/main/components/momentum/momentum_center.dart';
import 'package:tiny/screens/main/components/profile-info/profile_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiny/theme/style.dart';
import 'package:video_player/video_player.dart';

class StoryContentScreen extends StatefulWidget {
  final List<StoryContent> storyContents;
  final User user;

  const StoryContentScreen({@required this.storyContents, @required this.user});

  @override
  _StoryContentScreenState createState() => _StoryContentScreenState();
}

class _StoryContentScreenState extends State<StoryContentScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  VideoPlayerController _videoController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final StoryContent firstStory = widget.storyContents.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.storyContents.length) {
            _currentIndex += 1;
            _loadStory(story: widget.storyContents[_currentIndex]);
          } else {
            // Out of bounds - loop story
            Navigator.of(context).pop();
            // _currentIndex = 0;
            // _loadStory(story: widget.storyContents[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StoryContent story = widget.storyContents[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.storyContents.length,
              itemBuilder: (context, i) {
                final StoryContent story = widget.storyContents[i];
                return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            'https://s3-ap-southeast-1.amazonaws.com/tinyapp.ai/system_images/momentback.jpg'),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: momentDetail(story),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: ScreenUtil.defaultSize.width - 29,
                            height: 45,
                            padding: EdgeInsets.only(left: 20),
                            margin: EdgeInsets.only(
                                bottom: 31, left: 29, right: 29),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xccf1f1f2),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.send),
                                  hintText: 'Send message',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
                // return const SizedBox.shrink();
              },
            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.storyContents
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    child: UserInfo(user: widget.user),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget momentDetail(story) {
    switch (story.mediaType) {
      case "Buddy":
        return MomentumCenter(
          emoji: "🎉",
          line1: "CONGRATS!",
          line2: "BUDDIES!",
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileInfo(
                userName: "Solongo",
                profilePic:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21014.jpg",
                imageSize: 95.h,
                role: "creater",
              ),
              SizedBox(
                width: 16.h,
              ),
              ProfileInfo(
                userName: "Solongo",
                profilePic:
                    "https://yodacontent.s3.ap-northeast-2.amazonaws.com/tass/profilepics/21001.jpg",
                imageSize: 95.h,
                role: "creater",
              ),
            ],
          ),
        );
      case "Gratitude":
        return MomentumCenter(
            emoji: "🙏",
            line1: "MORNING",
            line2: "GRATITUDE!",
            line1Font: 18,
            widget: Container(
              width: 250.w,
              height: 164.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ligtGrey3,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "Thank full morning breakfast :P",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ligtGrey,
                    fontSize: 18,
                  ),
                ),
              ),
            ));
      case "Streak":
        return MomentumCenter(
          emoji: "🔥",
          line1: "MOMENTUM",
          line2: "STREAK!",
          widget: Column(children: [
            Container(
              width: 50.w,
              height: 71.h,
              child: SvgPicture.asset(
                'assets/svg/streak2.svg',
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: 144,
              height: 89,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 108,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffef508b),
                      ),
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 24,
                        bottom: 14,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 59,
                            height: 41,
                            child: Text(
                              "2x",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.80,
                      child: Container(
                        width: 120,
                        height: 67,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Color(0xffef508b),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: 0.40,
                      child: Container(
                        width: 130,
                        height: 77,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Color(0xffef508b),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.20,
                    child: Container(
                      width: 144,
                      height: 89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color(0xffef508b),
                          width: 0.50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        );
      case "Post":
        return Container();
      case "Badge":
        return MomentumCenter(
          emoji: "😎",
          line1: "NEW BADGE!",
          // line2: "BUDDIES!",
          widget: Container(
            width: 140.w,
            height: 140.h,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ligtGrey3,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: Center(
              child: CachedNetworkImage(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/en/thumb/2/29/Harvard_shield_wreath.svg/494px-Harvard_shield_wreath.svg.png",
              ),
            ),
          ),
        );
        return Container();
    }
    return Container();
  }

  void _onTapDown(TapDownDetails details, StoryContent storyContent) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.storyContents[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.storyContents.length) {
          _currentIndex += 1;
          _loadStory(story: widget.storyContents[_currentIndex]);
        } else {
          // Out of bounds - loop story
          Navigator.of(context).pop();
          // _currentIndex = 0;
          // _loadStory(story: widget.storyContents[_currentIndex]);
        }
      });
    } else {
      if (storyContent.mediaType == "Video") {
        if (_videoController.value.isPlaying) {
          _videoController.pause();
          _animController.stop();
        } else {
          _videoController.play();
          _animController.forward();
        }
      }
    }
  }

  void _loadStory({StoryContent story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();
    // switch (story.mediaType) {
    //   case "Image":
    _animController.duration = story.duration == 0 || story.duration == null
        ? new Duration(seconds: 10)
        : story.duration;
    _animController.forward();
    // break;
    // case "Video":
    //   _videoController = null;
    //   _videoController?.dispose();
    //   _videoController = VideoPlayerController.network(story.sourcePath)
    //     ..initialize().then((_) {
    //       setState(() {});
    //       if (_videoController.value.initialized) {
    //         _animController.duration = _videoController.value.duration;
    //         _videoController.play();
    //         _animController.forward();
    //       }
    //     });
    //   break;
    // }
    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key key,
    @required this.animController,
    @required this.position,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ProfileInfo(
            direction: "vertical",
            userName: user.firstName,
            profilePic: user.profilePic,
            imageSize: 53,
            role: "creater",
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
