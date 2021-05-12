import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny/screens/main/screens/profile/components/tempModels.dart';
import 'package:tiny/theme/style.dart';

class Goal extends StatefulWidget {
  const Goal({Key key, this.course}) : super(key: key);
  final Course course;

  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12 , bottom: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color:ligtGrey3 ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            title: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this.widget.course.name == null ? "" : this.widget.course.name,
                              style: GoogleFonts.openSans(
                                color: ligtGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              this.widget.course.name == null ? "" : "Growth: ${this.widget.course.value*100}%",
                              style: GoogleFonts.openSans(
                                color: ligtGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            !isExpanded ? Container(
                              height: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                child: LinearProgressIndicator(
                                  value: this.widget.course.value,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      lightGreen),
                                  backgroundColor: ligtGrey3,
                                ),
                              ),
                            ):Container(),
                          ],
                        ),
                      )),
                  ),
                  // Expanded(
                  //   child: Container(),
                  // )
                ],
              ),
            ),
            children: <Widget>[
              TopicWidget(),
              TopicWidget(),
              TopicWidget(),
              TopicWidget(),
              TopicWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Stack(
      children: <Widget>[
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                // 'https://www.insidehighered.com/sites/default/server_files/media/SAT_2.jpg'
                this.widget.course.photo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TopicWidget extends StatelessWidget {
  const TopicWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:20, right:20, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Heart of Algebra: 60%",
            style: GoogleFonts.openSans(
              color: ligtGrey,
              fontWeight: FontWeight.w400,
              fontSize: 10.0,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              child: LinearProgressIndicator(
                value: 0.6,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    lightGreen),
                backgroundColor: ligtGrey3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
