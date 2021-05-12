import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/models/post.dart';
import 'package:tiny/screens/main/components/community/join_community.dart';
import 'package:tiny/screens/main/components/community/community_members.dart';
import 'package:tiny/screens/main/components/onboard/congrats.dart';
import 'package:tiny/screens/main/components/onboard/dream_school.dart';
import 'package:tiny/screens/main/components/onboard/target_exam.dart';
import 'package:tiny/screens/main/components/onboard/target_progress.dart';
import 'package:tiny/screens/main/components/priming/priming.dart';
import 'package:tiny/screens/main/screens/feedback/feedback.dart';
import 'package:tiny/screens/main/screens/home/blocs/post/post_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiny/screens/main/screens/home/components/bottom_loader.dart';
import 'package:tiny/screens/main/screens/home/components/postComponent.dart';
import 'package:tiny/screens/main/screens/home/components/story.dart';
import 'package:tiny/theme/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

const assetName = 'assets/svg/tiny_name_logo.svg';

class OnboardFeedScreen extends StatefulWidget {
  const OnboardFeedScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnboardFeedScreenState();
  }
}

class _OnboardFeedScreenState extends State<OnboardFeedScreen> {
  static ScrollController _listViewController;
  List<Post> items;
  PostBloc _postBloc;
  @override
  void initState() {
    super.initState();
    _listViewController = new ScrollController()..addListener(_scrollListener);
    _postBloc = context.read<PostBloc>();
  }

  @override
  void dispose() {
    _listViewController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    'Daily progress',
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
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => FeedbackScreen()));
              },
              child: Text(
                "beta",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],

        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        child: Column(
          children: [
            StoryScreen(),
            Expanded(
              child:
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                switch (state.status) {
                  case PostStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                  case PostStatus.success:
                    if (state.posts.isEmpty) {
                      return const Center(child: Text('no posts'));
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.posts.length
                            ? BottomLoader()
                            : Column(
                                children: [
                                  CongratsWidget(),
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
                                ],
                              );
                        // : PostComponent(post: state.posts[index]);
                      },
                      itemCount: state.hasReachedMax
                          ? state.posts.length
                          : state.posts.length + 1,
                      controller: _listViewController,
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
          ],
        ),
        onRefresh: () async {
          print("Zayaaaa");
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void _scrollListener() {
    // print(_listViewController.position.extentAfter);
    // if (_isBottom) _postBloc.add(PostFetched());
    // setState(() {
    //   items.addAll(new List.generate(42, (index) => 'Inserted $index'));
    // });
  }

  bool get _isBottom {
    if (!_listViewController.hasClients) return false;
    final maxScroll = _listViewController.position.maxScrollExtent;
    final currentScroll = _listViewController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
