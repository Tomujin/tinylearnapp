import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tiny/models/curriculum.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/models/userCurriculum.dart';
import 'package:tiny/screens/main/app-screen.dart';
import 'package:tiny/screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';

class ChooseSubCourse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFf5f5f9),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Tap your important topic",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: BlocBuilder<SelectGoalBloc, SelectGoalState>(
            builder: (context, state) {
          return Column(children: [
            Expanded(
              child: RefreshIndicator(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        (state as SelectGoalSuccess).userCurriculums.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CurriculumDateChooser(
                          (state as SelectGoalSuccess).userCurriculums[index],
                          (state as SelectGoalSuccess).curriculums.firstWhere(
                              (item) =>
                                  item.id ==
                                  (state as SelectGoalSuccess)
                                      .userCurriculums[index]
                                      .curriculumId));
                    }),
                onRefresh: () async {},
              ),
            ),
            SizedBox(
              width: 150,
              child: RaisedButton(
                child: Text("Finish"),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () => {finishGoalPicker(context)},
              ),
            ),
            SizedBox(
              height: 30,
            )
          ]);
        }));
  }

  finishGoalPicker(BuildContext context) {
    BlocProvider.of<SelectGoalBloc>(context).add(SelectGoalSaved());
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => AppScreen(4)));
  }
}

class CurriculumDateChooser extends StatefulWidget {
  final UserCurriculum userCurriculum;
  final Curriculum curriculum;
  CurriculumDateChooser(this.userCurriculum, this.curriculum);

  @override
  _CurriculumDateChooserState createState() => _CurriculumDateChooserState();
}

class _CurriculumDateChooserState extends State<CurriculumDateChooser> {
  @override
  void initState() {
    super.initState();

    // if (widget.userCurriculum.applyingDate != null)
    //   selectedDate = widget.userCurriculum.applyingDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.curriculum.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 24.0,
              )),
          ...getWidget()
        ],
      ),
      padding: EdgeInsets.all(15),
    );
  }

//a34c5b21-a885-4739-8d66-bd87c84ef225
  List<Widget> getWidget() {
    if (widget.curriculum.childCurriculums.length != 0)
      return widget.curriculum.childCurriculums.map((childCurriculum) {
        final tmpUserCurriculum = widget.userCurriculum.userCurriculumRates;

        var tmpRate = 0.0;
        if (tmpUserCurriculum != null)
          tmpRate = tmpUserCurriculum
              .firstWhere((item) => item.curriculumId == childCurriculum.id,
                  orElse: () => null)
              ?.rate;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Opacity(
              opacity: 0.8,
              child: Text(childCurriculum.name,
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: Colors.grey[350],
                  )),
              child: RatingBar.builder(
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                initialRating: tmpRate ?? 0.0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  UserCurriculumRate userCurriculumRate =
                      new UserCurriculumRate(
                          rate: rating,
                          userCurriculumId: widget.curriculum.id,
                          curriculumId: childCurriculum.id);

                  if (widget.userCurriculum.userCurriculumRates == null)
                    widget.userCurriculum.userCurriculumRates = [];

                  if (widget.userCurriculum.userCurriculumRates
                          .where((item) =>
                              item.curriculumId ==
                              userCurriculumRate.curriculumId)
                          .length ==
                      0)
                    widget.userCurriculum.userCurriculumRates
                        .add(userCurriculumRate);
                  else
                    widget.userCurriculum.userCurriculumRates
                        .firstWhere((item) =>
                            item.curriculumId ==
                            userCurriculumRate.curriculumId)
                        .rate = rating;
                },
              ),
            )
          ],
        );
      }).toList();
    else
      return [Text('All topics selected')];
  }
}
