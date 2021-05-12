import 'dart:ui';
import 'package:tiny/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/content.dart';
import 'package:tiny/models/post.dart';
import 'package:tiny/resources/post-repository.dart';
import 'package:tiny/screens/main/components/video-player/video-player.dart';
// import 'question.dart';
// import 'quiz-logic.dart';

// QuizLogic logic = new QuizLogic();

class Assessment extends StatefulWidget {
  final Post post;
  final Function onAnswered;

  const Assessment({Key key, @required this.post, @required this.onAnswered})
      : super(key: key);

  @override
  _AssessmentState createState() => _AssessmentState();
}

class _AssessmentState extends State<Assessment> {
  Content content;
  int selectAnswerIndex = -1;
  String answerText;
  bool isAnswered;
  bool isCorrect;
  OverlayEntry entry;

  void initState() {
    super.initState();
    content = widget.post.contents[0];
    isAnswered = false;
    isCorrect = false;
  }

  void setAnswer() {
    print("setAnswer $selectAnswerIndex");
    if (selectAnswerIndex != -1) {
      setState(() {
        isAnswered = true;
      });
    }

    content.setUserAnswer(selectAnswerIndex, answerText);

    print(selectAnswerIndex);
    print(content.answers[0].id);
    content.answers.forEach((element) {
      print(element.id);
      print(element.answer);
    });

    GraphQLClient _client = GraphQLProvider.of(context).value;
    PostRepository _postRepo = PostRepository(_client);
    _postRepo.postUserAnswer(
        content.id,
        selectAnswerIndex > -1 ? content.answers[selectAnswerIndex].id : null,
        answerText);
    setState(() {
      widget.onAnswered();
    });
  }

  Widget createAnswers() {
    switch (content.answerType) {
      case "MultipleChoice":
        List<Widget> answers = new List<Widget>();
        print(content.contentText);
        var size = MediaQuery.of(context).size;

        /*24 is for notification bar on RAndroid*/
        final double itemHeight = (size.height * 0.33 -
            // size.width -

            // 50.h -
            6 * content.answers.length -
            ScreenUtil().bottomBarHeight -
            MediaQuery.of(context).padding.top);

        final double itemWidth = size.width;

        content.answers.forEach((element) {
          Widget answerWidget;
          if (element.mediaType == 'Text') {
            answerWidget = Expanded(
              child: Text(
                element.answer,
                style: GoogleFonts.openSans(),
              ),
              // padding: EdgeInsets.all(2.0),
            );
          } else {
            answerWidget = Expanded(
              child: Text(
                element.answer,
                style: GoogleFonts.openSans(),
              ),
              // padding: EdgeInsets.all(2.0),
            );
          }
          answers.add(
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: FlatButton(
                onPressed: () {
                  if (selectAnswerIndex == content.answers.indexOf(element)) {
                    setState(() {
                      selectAnswerIndex = -1;
                      isCorrect = false;
                    });
                  } else {
                    setState(() {
                      selectAnswerIndex = content.answers.indexOf(element);
                      isCorrect = element.point > 0;
                    });
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.radio_button_off_outlined,
                      color:
                          selectAnswerIndex == content.answers.indexOf(element)
                              ? Color(0xffef508b)
                              : Color.fromRGBO(218, 218, 218, 1),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    answerWidget
                    // Text(
                    //   "1120",
                    //   style: GoogleFonts.openSans(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16,
                    //       color: ligtGrey),
                    // ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: selectAnswerIndex ==
                                content.answers.indexOf(element)
                            ? Color(0xffef508b)
                            : Color.fromRGBO(218, 218, 218, 1)),
                    borderRadius: new BorderRadius.circular(16)),
              ),
              // child: FlatButton(
              //   shape: RoundedRectangleBorder(
              //       side: BorderSide(
              //           width: 1,
              //           style: BorderStyle.solid,
              //           color: selectAnswerIndex ==
              //                   content.answers.indexOf(element)
              //               ? Color.fromRGBO(120, 81, 162, 1)
              //               : Color.fromRGBO(218, 218, 218, 1)),
              //       borderRadius: new BorderRadius.circular(10)),
              //   onPressed: () {
              //     if (selectAnswerIndex == content.answers.indexOf(element)) {
              //       setState(() {
              //         selectAnswerIndex = -1;
              //         isCorrect = false;
              //       });
              //     } else {
              //       setState(() {
              //         selectAnswerIndex = content.answers.indexOf(element);
              //         isCorrect = element.point > 0;
              //       });
              //     }
              //   },
              //   child: answerWidget,
              // ),
            ),
          );
        });

        answers.add(
          // Container(
          //   // color: Colors.black12,
          //   height: 50.h,
          //   padding: EdgeInsets.all(10.h),
          //   child: Stack(
          //     children: [

          Padding(
            padding: EdgeInsets.only(left: 43.w, right: 43.w, top: 8),
            child: Container(
              width: double.infinity,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () {
                  setAnswer();
                },
                child: Text('Confirm',
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
              ),
            ),
            // child: Center(
            // child: FlatButton(
            //   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(35)),
            //   onPressed: () => setAnswer(),
            //   child: Text(
            //     'Confirm',
            //     style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, decoration: TextDecoration.none),
            //   ),
            //   color: Color.fromRGBO(239, 80, 139, 1),
            // ),
          ),

          //     ],
          //   ),
          // ),
        );
        print("ddd ${(itemWidth / itemHeight) * content.answers.length}");
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 1,
          childAspectRatio: ((itemWidth / itemHeight) * content.answers.length),
          children: answers,
        );
        break;
      case "Text":
        return new Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter answer here...',
            ),
          ),
        );
      default:
        return new Container();
        break;
    }
  }

  Widget createContent() {
    Widget contentWidget;
    switch (widget.post.contents[0].mediaType) {
      case "Image":
        contentWidget = Image(
          image: NetworkImage(widget.post.contents[0].sourcePath),
        );
        break;
      case "Text":
        contentWidget = Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(239, 80, 139, 1),
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: NetworkImage(
          //           "https://media.istockphoto.com/vectors/abstract-square-white-background-geometric-minimalistic-cover-design-vector-id916617930?b=1&k=6&m=916617930&s=612x612&w=0&h=PSmxmODUAcfbscaM528CI9TMsvCxL8z44LekwPvawNw="),
          //       fit: BoxFit.cover),
          // ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(34),
              child: Text(
                widget.post.contents[0].contentText ?? "",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        );
        break;
      case "Latex":
        contentWidget = Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://media.istockphoto.com/vectors/abstract-square-white-background-geometric-minimalistic-cover-design-vector-id916617930?b=1&k=6&m=916617930&s=612x612&w=0&h=PSmxmODUAcfbscaM528CI9TMsvCxL8z44LekwPvawNw="),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: TeXView(
                child: TeXViewDocument(r"""
     When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
     $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$<br>""",
                    style: TeXViewStyle(margin: TeXViewMargin.only(top: 10)))),
          ),
        );
        break;
      case "Video":
        contentWidget = Container(
          child: TinyVideoPlayer(videoPath: content.sourcePath),
        );
        break;
      default:
        contentWidget = Container();
        break;
    }

    return contentWidget;
  }

  Widget createResult(bool result) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(50),
            child: Text(
              result.toString(),
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  color: result ? Colors.green : Colors.red,
                  decoration: TextDecoration.none),
            )));
  }

  Future<void> showPassageDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Passage'),
          content: SingleChildScrollView(
            child: Text(content.post.passage.text),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget titleRow() => Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 34, top: 19, bottom: 19),
                child: Text(
                  'ASSESSMENT',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Color.fromRGBO(82, 82, 82, 1),
                  ),
                ),
              ),
            ],
          ),
          // Expanded(child: SizedBox()),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: ScreenUtil().screenHeight,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            titleRow(),
            Container(
              child: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue[100],
                      ),
                      alignment: Alignment.center,
                      child: createContent()),
                  // Positioned(
                  //     child: IconButton(
                  //   icon: Icon(Icons.info),
                  //   onPressed: () => {print(content.post.passage.text)},
                  // ))
                ],
              ),
            ),
            Container(
                transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                child: content.post.passage != null
                    ? FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        child: Text("Passage"),
                        color: Colors.black.withOpacity(0.3),
                        onPressed: () => {
                          showPassageDialog()
                          //print(content.post.passage.text)
                        },
                      )
                    : null),
            Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: isAnswered ? createResult(isCorrect) : createAnswers(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
