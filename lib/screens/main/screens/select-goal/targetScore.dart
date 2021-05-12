import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/models/curriculum.dart';
import 'package:tiny/models/userCurriculum.dart';
import 'package:tiny/screens/main/screens/select-goal/applyYear.dart';
import 'package:tiny/screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';

class TargetScore extends StatelessWidget {
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
          title: Text("Let's determine the target",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
            child: RefreshIndicator(
              child: BlocBuilder<SelectGoalBloc, SelectGoalState>(
                  builder: (context, state) {
                return ListView.builder(
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
                    });
              }),
              onRefresh: () async {},
            ),
          ),
          SizedBox(
            width: 150,
            child: RaisedButton(
              child: Text("Continue"),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30)),
              onPressed: () => {pushToScreen(context)},
            ),
          ),
          SizedBox(
            height: 30,
          )
        ]));
  }

  pushToScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ApplyYear()));
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
  String dropdownValue = '1300';

  @override
  void initState() {
    super.initState();
    if (widget.userCurriculum.point != null)
      dropdownValue = widget.userCurriculum.point.toString();
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
          Opacity(
            opacity: 0.8,
            child: Text('Choose target score',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.0,
                )),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                widget.userCurriculum.point = int.parse(newValue);
              });
            },
            items: <String>['1300', '1400', '1500', '1600']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
