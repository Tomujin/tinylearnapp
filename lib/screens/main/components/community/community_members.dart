import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/screens/main/components/community/bloc/community_bloc.dart';
import 'package:tiny/screens/main/components/profile-info/profile_follow.dart';
import 'package:tiny/screens/main/components/profile-info/profile_info.dart';
import 'package:tiny/screens/main/screens/home/components/bottom_loader.dart';
import 'package:tiny/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MembersWidget extends StatefulWidget {
  final String communityId;

  const MembersWidget({Key key, this.communityId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MembersWidgetState();
  }
}

class _MembersWidgetState extends State<MembersWidget> {
  int pageViewActiveIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _comBloc = BlocProvider.of<CommunityBloc>(context);
    _comBloc.add(MemberLoadEvent());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 1.2,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Follow community members",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              // fontFamily: "Open Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 31.h,
          ),
          BlocBuilder<CommunityBloc, CommunityState>(builder: (context, state) {
            if (state is MemberLoadingState) {
              BottomLoader();
            } else if (state is MemberLoadedState) {
              return GridView.builder(
                itemCount: state.users.length > 6 ? 6 : state.users.length,
                padding: EdgeInsets.only(left: 53.0.w, right: 53.w),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 6.0.h,
                  crossAxisSpacing: 7.0.w,
                  childAspectRatio: (86.w / 124.h),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProfileFollow(
                    userName: state.users[index].userName,
                    profilePic: state.users[index].profilePic,
                    imageSize: 59.h,
                    role: "creater",
                  );
                },
              );
            }
          }),
          SizedBox(
            height: 31.h,
          ),
          ButtonTheme(
            minWidth: 200.0.w,
            height: 40.h,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              color: Theme.of(context).primaryColor,
              // side: BorderSide(color: Colors.red)),
              onPressed: () {},
              child: Text(
                "All members follow",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
