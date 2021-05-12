import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/resources/post-repository.dart';
import 'package:tiny/screens/main/components/assessment/assessment.dart';
import 'package:tiny/screens/main/components/comment/comment_screen.dart';
import 'package:tiny/screens/main/components/post/content.dart';
import 'package:tiny/screens/main/screens/home/blocs/comment/comment_bloc.dart';
import 'package:tiny/screens/main/screens/home/blocs/reaction/reaction_bloc.dart';
import 'package:tiny/screens/main/screens/home/components/reaction_button.dart';
import 'package:tiny/services/secure-storage.dart';
import 'package:tiny/theme/style.dart';
import 'package:tiny/utils/tiny_icons.dart';
import 'circle_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:tiny/screens/main/screens/profile/bloc/profile_bloc.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';

class PostComponent extends StatefulWidget {
  final Post post;
  const PostComponent({Key key, this.post}) : super(key: key);
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<PostComponent> {
  final SecureStorage _secureStorage = new SecureStorage();
  int pageViewActiveIndex = 0;
  String userId;
  int likeCount = -1;
  int commentCount = 0;

  var commentController = TextEditingController();
  final String caption =
      '''Styling text in Flutter #something, Styling text in Flutter. #Another, #nepal, Styling text in Flutter. #ktm, #love, #newExperiance Styling text in Flutter. Styling text in Flutter. Styling text in Flutter.''';
  PostRepository _postRepo;
  @override
  Widget build(BuildContext context) {
    GraphQLClient _client = GraphQLProvider.of(context).value;
    _postRepo = PostRepository(_client);
    print("title ${widget.post.title}");
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext ctx, stateAuth) {
      this.userId = (stateAuth as AuthenticationAuthenticated).user.id;
      return widget.post.postType != "Assessment"
          ? Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Lesson Info Row
                  lessonInfoRow(),

                  // For padding
                  SizedBox(height: 8.0),
                  // Single or collection of images/videos

                  gallery(),
                  // For padding
                  galleryCount(),
                  SizedBox(height: 10.0),
                  // User profile, name and more option
                  separater(),
                  SizedBox(height: 10.0),
                  userInfoRow(),
                  SizedBox(height: 10.0),
                  // separater(),
                  // Different icon buttons and image slider indicator
                  // SizedBox(height: 10.0),
                  // People liked information with icon
                  // likeCounts(),
                  // SizedBox(height: 8.0),
                  //Caption
                  // galleryCaption(),
                  // For padding
                  // SizedBox(height: 4.0),
                  // View all comments
                  comments(),
                  // For padding
                  // SizedBox(height: 4.0),
                  // // Add comment section
                  // addComment(),
                ],
              ),
              padding: EdgeInsets.only(top: mainSpace),
              // decoration: BoxDecoration(
              //   border: Border(
              //     top: BorderSide(color: Theme.of(context).dividerColor),
              //   ),
              // ),
            )
          : Column(
              children: [
                separater(),
                Assessment(
                    post: widget.post,
                    onAnswered: () => {
                          // startTimeout(),
                        })
              ],
            );
    });
  }

  Widget lessonInfoRow() => Row(
        children: [
          SizedBox(width: mainSpace),
          Container(
            alignment: Alignment.center,
            height: 29.h,
            width: 29.h,
            child: Text("SAT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 6,
                  color: Colors.white,
                )),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(29.h))),
          ),
          SizedBox(width: mainSpace),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  widget
                      .post.postCurriculums[0].curriculum.parentCurriculum.name,
                  // .toUpperCase(),
                  // widget.post.user.firstName == null
                  //     ? "User"
                  //     : widget.post.user.firstName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: darkGrey)),
              Text(widget.post.postCurriculums[0].curriculum.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey)),
            ],
          ),
          Expanded(child: SizedBox()),
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      );
  Widget userInfoRow() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: mainSpace), // For padding
              ClipRRect(
                child: Image.network(
                  widget.post.user.profilePic,
                  fit: BoxFit.cover,
                  width: inPostUserPictureSize,
                  height: inPostUserPictureSize,
                ),
                borderRadius: BorderRadius.circular(inPostUserPictureSize),
              ),
              SizedBox(width: 12.0), // For padding
              Text(
                "Content by ",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Text(
                widget.post.user.firstName == null
                    ? "User"
                    : widget.post.user.firstName,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Content by ",
                  //       style: TextStyle(fontSize: 14, color: Colors.black),
                  //     ),
                  //     Text(
                  //       widget.post.user.firstName == null
                  //           ? "User"
                  //           : widget.post.user.firstName,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 14,
                  //           color: Colors.black),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    widget.post.user.bio == null ? "" : widget.post.user.bio,
                    // 'Harvard ph.D',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color(0xFF777777)),
                  ),
                  // Text(
                  //   widget.post.user.sub == null
                  //       ? "Learned by"
                  //       : widget.post.user.sub,
                  //   // 'Harvard ph.D',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 10,
                  //       color: Color(0xFF777777)),
                  // ),
                ],
              ),
              Expanded(child: SizedBox()),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (BuildContext ctx, stateAuth) {
                return ReactionButton(selectedIndex: -1);
              }),

              // SizedBox(width: 10.0), // For padding
              IconButton(
                  onPressed: () => {
                        goToComments(
                          context: context,
                          postId: widget.post.id,
                        )
                      },
                  icon: Icon(Tiny.comment, color: Colors.grey)),

              IconButton(
                  icon: widget.post.isSaved
                      ? Icon(Icons.bookmark, color: Colors.grey)
                      : Icon(Icons.bookmark_outline_rounded,
                          color: Colors.grey),
                  onPressed: () {
                    print("----${widget.post.userSavedPostId}");
                    if (widget.post.isSaved) {
                      _postRepo
                          .deleteUserSavedPost(widget.post.userSavedPostId);
                      setState(() {
                        widget.post
                            .changeSavedState(saved: !widget.post.isSaved);
                      });
                    } else {
                      showBottomSheet();
                    }
                  }),
              SizedBox(width: 12.0), // For padding
            ],
          ),
          Row(
            children: [
              SizedBox(width: mainSpace),
              // ClipRRect(
              //   child: Image.network(widget.post.user.profilePic,
              //       fit: BoxFit.cover, width: 18, height: 18),
              //   borderRadius: BorderRadius.circular(12),
              // ),

              Text(
                widget.post.user.sub == null
                    ? "Learned by "
                    : widget.post.user.sub,
                // 'Harvard ph.D',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF777777)),
              ),
              Text(
                widget.post.user.sub == null
                    ? "zayadelgerz"
                    : widget.post.user.sub,
                // 'Harvard ph.D',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      );

  Widget createPost() {
    return widget.post.contents.length > 1
        ? galleryPageView()
        : ContentWidget(content: widget.post.contents[0]);
    // }
  }

  Widget gallery() => Container(
      constraints: BoxConstraints(
        // TODO post heigth
        maxHeight: ScreenUtil().screenWidth, // changed to 400
        minHeight: 200.0, // changed to 200
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200],
            width: 1.0,
          ),
        ),
      ),
      // child: Image.asset(
      //   UIImageData.storiesList[index],
      //   fit: BoxFit.contain,
      // ),
      child: createPost()
      // child: widget.post.contents.length > 1
      //     ? galleryPageView()
      //     : Image.network(
      //         widget.post.contents[0].sourcePath,
      //         fit: BoxFit.contain,
      //       ),
      );

  Widget galleryPageView() {
    return PageView.builder(
      itemCount: widget.post.contents.length,
      onPageChanged: (currentIndex) {
        setState(() {
          this.pageViewActiveIndex = currentIndex;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return ContentWidget(content: widget.post.contents[index]);
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: new Container(
            height: 200.h,
            width: 375.w,
            padding: EdgeInsets.symmetric(horizontal: 37, vertical: 35),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                )),
            child: Column(
              children: [
                FlatButton(
                  onPressed: () {
                    save(false);
                    Navigator.of(context).pop();
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 45.w,
                            height: 45.h,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/svg/paint.svg",
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(248, 248, 249, 1),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "Private",
                            style: TextStyle(
                                fontSize: 16.ssp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 23.h),
                  child: FlatButton(
                    onPressed: () {
                      save(true);
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Container(
                            width: 45.w,
                            height: 45.h,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/svg/fire.svg",
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(248, 248, 249, 1),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            "Public",
                            style: TextStyle(
                                fontSize: 16.ssp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> save(bool isPublic) async {
    String id = await _postRepo.postUserSavedPost(
        widget.post.id, isPublic, this.userId);

    setState(() {
      widget.post.changeSavedState(saved: !widget.post.isSaved, id: id);
    });
  }

  Widget galleryCount() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...widget.post.contents.map((s) {
              return Container(
                margin: EdgeInsets.only(right: 4.0),
                height: widget.post.contents.length <= 1 ? 0.0 : 6.0,
                width: widget.post.contents.length <= 1 ? 0.0 : 6.0,
                decoration: BoxDecoration(
                  color: pageViewActiveIndex == widget.post.contents.indexOf(s)
                      ? appTheme().accentColor
                      : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              );
            }),
          ],
        ),
      );

  Widget actions() => Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          // Actions buttons/icons
          Row(
            children: <Widget>[
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (BuildContext ctx, stateAuth) {
                return IconButton(
                  icon: widget.post.isReacted.length > 0
                      ? Icon(Icons.thumb_up)
                      : Icon(Icons.thumb_up_alt_outlined),
                  onPressed: () => {
                    if (widget.post.isReacted.length > 0)
                      {
                        //if (stateAuth is LoadProfileEvent)
                        BlocProvider.of<ReactionBloc>(context)
                            .add(ReactionUnSaved(
                          id: widget.post.isReacted,
                        ))
                      }
                    else
                      BlocProvider.of<ReactionBloc>(context).add(ReactionSaved(
                          userId: (stateAuth as AuthenticationAuthenticated)
                              .user
                              .id,
                          postId: widget.post.id,
                          reactionTypes: 1))
                  },
                );
              }), // For padding
              Icon(Icons.comment_bank_outlined),
              SizedBox(width: 16.0), // For padding

              Transform.rotate(
                angle: 0.4,
                child: Icon(Icons.share_outlined),
              ),
              SizedBox(width: 10.0), // For padding
            ],
          ),
        ],
      );

  Widget likeCounts() => Row(
        children: <Widget>[
          // SizedBox(width: 12.0), // For padding
          if (widget.post.postReactions != null &&
              widget.post.postReactions.length > 0)
            Stack(
                fit: StackFit.loose,
                textDirection: TextDirection.rtl,
                children: [
                  ...widget.post.postReactions.take(3).map((postreaction) {
                    if (likeCount == 2) {
                      likeCount = 0;
                    } else {
                      likeCount++;
                    }

                    return Container(
                      height: 22.0,
                      width: 22.0,
                      margin: EdgeInsets.only(right: likeCount * 14.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/test.jpg'),
                        ),
                      ),
                    );
                  }),
                ]),

          SizedBox(width: 8.0), // For padding
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  if (widget.post.reactionCount != null &&
                      widget.post.reactionCount > 0)
                    TextSpan(
                      text: 'Thanked by ',
                      style: TextStyle(color: Colors.black54),
                    ),
                  if (widget.post.reactionCount != null &&
                      widget.post.reactionCount > 0)
                    TextSpan(
                      text: widget.post.postReactions[0].user.firstName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  if (widget.post.reactionCount != null &&
                      widget.post.reactionCount > 1)
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(color: Colors.black54),
                    ),
                  if (widget.post.reactionCount != null &&
                      widget.post.reactionCount > 1)
                    TextSpan(
                      text: (widget.post.reactionCount - 1).toString() +
                          ' others ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          ),
        ],
      );

  Widget galleryCaption() => Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 16),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: widget.post.totalCount > 1
                ? [
                    TextSpan(
                      text: widget.post.comments[0].user.firstName + ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ..._processCaption(
                      widget.post.comments[0].comment,
                      '#',
                      TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ]
                : [TextSpan()],
          ),
        ),
      );

  List<TextSpan> _processCaption(
      String caption, String matcher, TextStyle style) {
    List<TextSpan> spans = [];

    caption.split(' ').forEach((text) {
      if (text.toString().contains(matcher)) {
        spans.add(TextSpan(text: text + ' ', style: style));
      } else {
        spans.add(TextSpan(text: text + ' '));
      }
    });

    return spans;
  }

  Widget comments() => Padding(
        padding: const EdgeInsets.only(left: mainSpace),
        child: widget.post.totalCount > 1
            ? InkWell(
                onTap: () {
                  goToComments(
                    context: context,
                    postId: widget.post.id,
                  );
                },
                child: Text(
                  'View all ' + widget.post.totalCount.toString() + ' comments',
                  style: TextStyle(color: Colors.black54, fontSize: 11),
                ),
              )
            : null,
      );

  Widget addComment() => Row(
        children: <Widget>[
          CircleImage(
            'assets/images/test.jpg',
            imageSize: 30.0,
            whiteMargin: 2.0,
            imageMargin: 6.0,
          ),
          Container(child:
              BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
            if (state is CommentSaveSuccess) {
              clearTextField();
            }
            return Expanded(
              child: TextField(
                onSubmitted: (value) => BlocProvider.of<CommentBloc>(context)
                    .add(CommentAdded(
                        userId: widget.post.user.id,
                        postId: widget.post.id,
                        comment: value)),
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: InputBorder.none,
                ),
              ),
            );
          })),
          Text('🤗', style: TextStyle(fontSize: 14.0)),
          SizedBox(width: 10.0),
          Text('😘', style: TextStyle(fontSize: 14.0)),
          SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.add_circle_outline,
              size: 15.0,
              color: Colors.black26,
            ),
          ),
          SizedBox(width: 12.0),
        ],
      );

  Widget separater() => Container(
        constraints: BoxConstraints(
          maxWidth: double.infinity,
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          //color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey[200],
              width: 1.0,
            ),
          ),
        ),
      );
  void clearTextField() {
    commentController.clear();
  }

  Future<void> goToComments({
    BuildContext context,
    String postId,
    String ownerId,
    String mediaUrl,
  }) async {
    String userId = await _secureStorage.getSecureStore("userId");
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return CommentScreen(postId: postId, postOwner: ownerId, userId: userId);
    }));
  }
}
