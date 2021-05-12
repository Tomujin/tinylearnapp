import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/models/curriculum.dart';
import 'package:tiny/models/userCurriculum.dart';
import 'package:tiny/screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';
import 'package:tiny/screens/main/screens/select-goal/chooseSubCourse.dart';
import 'package:tiny/theme/style.dart';

class ApplyYear extends StatelessWidget {
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
          title:
              Text("When it take place", style: TextStyle(color: Colors.black)),
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
                child: Text("Continue"),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)),
                onPressed: () => {pushToScreen(context)},
              ),
            ),
            SizedBox(
              height: 30,
            )
          ]);
        }));
  }

  pushToScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ChooseSubCourse()));
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
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.userCurriculum.applyingDate != null)
      selectedDate = widget.userCurriculum.applyingDate;
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
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(selectedDate.toString().substring(0, 10),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.0,
                )),
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Select date',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            color: lightPurple,
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        widget.userCurriculum.applyingDate = picked;
      });
  }
}
