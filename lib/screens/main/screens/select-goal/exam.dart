import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/models/curriculum.dart';
import 'package:tiny/models/userCurriculum.dart';
import 'package:tiny/screens/main/screens/select-goal/targetScore.dart';
//import 'package:tiny/screens/main/screens/select-goal/apply_year.dart';
import 'package:tiny/screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';

const assetName = 'assets/svg/tiny_name_logo.svg';

class ExamScreen extends StatefulWidget {
  const ExamScreen({Key key}) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  List<Curriculum> curriculums; // = logic.getCurriculums();

  // @override
  // void initState() {
  //   super.initState();
  // }

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
        title: Text("Let's choose the curriculum",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: BlocBuilder<SelectGoalBloc, SelectGoalState>(
            builder: (context, state) {
          List<UserCurriculum> userCurriculums = [];

          if (state is SelectGoalSuccess) {
            userCurriculums = state.userCurriculums;
            curriculums = state.curriculums;
          }
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: curriculums == null ? 0 : curriculums.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<SelectGoalBloc>(context).add(
                              SelectCurriculumEvent(
                                  curriculums[index].id,
                                  (BlocProvider.of<AuthenticationBloc>(context)
                                          .state as AuthenticationAuthenticated)
                                      .user
                                      .id));
                        },
                        child: exams(
                            curriculums[index],
                            context,
                            userCurriculums == null
                                ? false
                                : userCurriculums
                                        .where((fields) =>
                                            fields.curriculumId ==
                                            curriculums[index].id)
                                        .toList()
                                        .length !=
                                    0),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)),
                    child: Text("Continue"),
                    onPressed: () => {
                      if (userCurriculums.length != 0) pushToScreen(context)
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          );
        }),
        onRefresh: () async {},
      ),
      backgroundColor: Colors.white,
    );
  }
}

pushToScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => TargetScore()));
}

Widget exams(Curriculum curriculum, BuildContext context, bool iselected) {
  return Container(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: iselected
              ? Border.all(color: Colors.purple)
              : Border.all(color: Color.fromRGBO(248, 248, 249, 1)),
          color: Color.fromRGBO(248, 248, 249, 1),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Icon(Icons.check_circle_outline,
                          color: iselected ? Colors.purple : Colors.grey)),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      curriculum.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  // RaisedButton(
                  //     child: Text("Add target score"), onPressed: () => {}),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
