import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:tiny/theme/style.dart';

class AddComment extends StatelessWidget {
  final TextEditingController commentController;
  final Function addComment;
  final String avatarUrl;
  // final String comment;
  // final DateTime timestamp;

  AddComment({
    this.commentController,
    this.addComment,
    this.avatarUrl,
    // this.comment,
    // this.timestamp
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        // padding: EdgeInsets.only(left: 10, right: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "❤️",
              style: TextStyle(fontSize: 20),
            ),
            Text("🙌", style: TextStyle(fontSize: 20)),
            Text("🔥", style: TextStyle(fontSize: 20)),
            Text("👏", style: TextStyle(fontSize: 20)),
            Text("😢", style: TextStyle(fontSize: 20)),
            Text("😍", style: TextStyle(fontSize: 20)),
            Text("😮", style: TextStyle(fontSize: 20)),
            Text("😂", style: TextStyle(fontSize: 20)),
          ],
          // ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(avatarUrl),
            ),
            Container(
                // height: 40,
                padding: EdgeInsets.only(right: 10, left: 10),
                margin: const EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: ligtGrey2),
                  borderRadius: BorderRadius.all(Radius.circular(
                          25) //                 <--- border radius here
                      ),
                ),

                // crossAxisAlignment: CrossAxisAlignment.start,
                child: Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil.defaultSize.width * 0.79,
                      child: TextFormField(
                        controller: commentController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add a comment...',
                        ),
                        onFieldSubmitted: addComment,
                        minLines: 1,
                        maxLines: 5,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        addComment(commentController.text);
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          // color: commentController.text.length == 0
                          //     ? ligtGrey4
                          //     : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        )
      ],
    );

    // ListTile(
    //   title: TextFormField(
    //     controller: commentController,
    //     keyboardType: TextInputType.multiline,
    //     decoration: InputDecoration(
    //       hintText: 'Add a comment...',
    //       // border: OutlineInputBorder(
    //       //   borderRadius: BorderRadius.circular(49.0),
    //       // ),
    //     ),
    //     onFieldSubmitted: addComment,
    //     minLines: 1,
    //     maxLines: 5,
    //   ),
    //   leading: CircleAvatar(
    //     backgroundImage: NetworkImage(avatarUrl),
    //     radius: 16,
    //   ),
    //   trailing: InkWell(
    //     onTap: () {
    //       addComment(commentController.text);
    //     },

    //     // borderSide: BorderSide.none,
    //     child: Text(
    //       "Post",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           color: Theme.of(context).primaryColor),
    //     ),
    //   ),
    // );
  }
}
