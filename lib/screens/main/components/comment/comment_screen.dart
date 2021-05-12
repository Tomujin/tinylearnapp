import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tiny/models/comment.dart';
import 'package:tiny/models/postReacion.dart';
import 'package:tiny/resources/post-repository.dart';
import 'package:tiny/screens/main/components/comment/add_comment.dart';
import "dart:async";

import 'package:tiny/screens/main/components/comment/comment_unit.dart';
import 'package:tiny/theme/style.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
  final String userId;

  const CommentScreen({this.postId, this.postOwner, this.userId});
  @override
  _CommentScreenState createState() => _CommentScreenState(
      postId: this.postId, postOwner: this.postOwner, userId: this.userId);
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String postOwner;
  final String userId;
  PostRepository _postRepo;
  bool didFetchComments = false;
  List<CommentUnit> fetchedComments = [];

  final TextEditingController _commentController = TextEditingController();

  _CommentScreenState({this.postId, this.postOwner, this.userId});
  @override
  void initState() {
    _postRepo = RepositoryProvider.of<PostRepository>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: buildComments(),
          ),
          Divider(
            color: ligtGrey2,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, bottom: 40),
            child: AddComment(
                commentController: _commentController,
                addComment: addComment,
                avatarUrl:
                    "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
          )
        ],
      ),
    );
  }

  Widget buildComments() {
    if (this.didFetchComments == false) {
      return FutureBuilder<List<CommentUnit>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());

            this.didFetchComments = true;
            this.fetchedComments = snapshot.data;
            return ListView(
              children: snapshot.data,
            );
          });
    } else {
      // for optimistic updating
      return ListView(children: this.fetchedComments);
    }
  }

  Future<List<CommentUnit>> getComments() async {
    List<CommentUnit> comments = [];

    List<Comment> postComments = await _postRepo.getPostComments(this.postId);
    comments = postComments
        .map((e) => CommentUnit(
              avatarUrl: e.user.profilePic,
              username: e.user.userName,
              comment: e.comment,
            ))
        .toList();

    return comments;
  }

  addComment(String comment) async {
    await _postRepo.postCommentSaved(
        userId: this.userId,
        postId: this.postId,
        comment: _commentController.text);
    getComments();
    _commentController.clear();
  }
}
