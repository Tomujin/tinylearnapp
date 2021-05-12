// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tiny/models/curriculum_school.dart';
// import 'package:tiny/screens/main/screens/select-goal/exam.dart';

// import 'bloc/onboard_bloc.dart';

// const assetName = 'assets/svg/tiny_name_logo.svg';

// class SchoolSelectionScreen extends StatefulWidget {
//   const SchoolSelectionScreen({Key key}) : super(key: key);
//   @override
//   _SchoolSelectionScreenState createState() => _SchoolSelectionScreenState();
// }

// class _SchoolSelectionScreenState extends State<SchoolSelectionScreen> {
//   // List<DreamSchool> curs = logic.getSchools();

//   @override
//   Widget build(BuildContext context) {
//     List<CurriculumSchool> curSchools = [];
//     OnboardBloc oBlock = BlocProvider.of<OnboardBloc>(context);
//     oBlock.add(LoadCurriculumSchoolEvent());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFf5f5f9),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_rounded),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text("Pick your dream schools",
//             style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: BlocProvider<OnboardBloc>(
//         create: (BuildContext context) {
//           return oBlock;
//         },
//         // child: RefreshIndicator(
//         child: BlocBuilder<OnboardBloc, SelectGoalState>(
//             builder: (context, state) {
//           List<CurriculumSchool> selectedSchools = List();
//           if (state is ) {
//             curSchools = state.curriculumSchools;
//             return buildSchools(context, oBlock, curSchools, selectedSchools);
//           } else if (state is SelectGoalSuccess) {
//             selectedSchools = state.schools;
//             return buildSchools(context, oBlock, curSchools, selectedSchools);
//           } else {
//             return Text("Loading");
//           }
//         }),
//         //   onRefresh: () async {},
//         // )
//         // backgroundColor: Colors.white,
//       ),
//     );
//   }
// }

// pushToScreen(BuildContext context) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//         builder: (_) => ExamScreen(
//             // user: this.user,
//             )),
//   );
// }

// Widget buildSchools(BuildContext context, OnboardBloc oBloc,
//     List<CurriculumSchool> curSchools, List<CurriculumSchool> selectedSchools) {
//   return Container(
//     child: Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: curSchools == null ? 0 : curSchools.length,
//             itemBuilder: (BuildContext context, int index) {
//               bool isSelected = selectedSchools.contains(curSchools[index]);
//               return InkWell(
//                 onTap: () {
//                   print("Buffon");
//                   isSelected
//                       ? selectedSchools.remove(curSchools[index])
//                       : selectedSchools.add(curSchools[index]);
//                   oBloc.add(SelectSchoolEvent(selectedSchools));
//                 },
//                 child: schools(curSchools[index], context, isSelected),
//               );
//             },
//           ),
//         ),
//         RaisedButton(
//           child: Text('Next'),
//           onPressed: () => {pushToScreen(context)},
//           // onPressed: () => {},
//         )
//       ],
//     ),
//   );
// }

// Widget schools(CurriculumSchool school, BuildContext context, bool isSelected) {
//   return Container(
//       child: Padding(
//     padding: EdgeInsets.all(10),
//     child: Container(
//       height: 160,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         color: Color.fromRGBO(248, 248, 249, 1),
//         border: isSelected
//             ? Border.all(color: Colors.purple)
//             : Border.all(color: Color.fromRGBO(248, 248, 249, 1)),
//       ),
//       child: Container(
//         margin: EdgeInsets.only(left: 25.0, top: 22.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Icon(Icons.check_circle_outline, color: Colors.grey),
//                 // imageWidget(),
//               ],
//             ),
//             SizedBox(height: 60.0),
//             Padding(
//               padding: EdgeInsets.only(bottom: 4),
//               child: Text(
//                 school.name,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.normal,
//                   fontSize: 24.0,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     ),
//   ));
// }
