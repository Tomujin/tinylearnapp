// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tiny/models/curriculum.dart';
// import 'package:tiny/screens/main/screens/select-goal/apply_year.dart';
// import 'package:tiny/screens/main/screens/select-goal/bloc/onboard_bloc.dart';
// import 'package:tiny/screens/main/screens/select-goal/career.dart';

// const assetName = 'assets/svg/tiny_name_logo.svg';

// class IntensityScreen extends StatefulWidget {
//   const IntensityScreen({Key key}) : super(key: key);

//   @override
//   _IntensityScreenState createState() => _IntensityScreenState();
// }

// class _IntensityScreenState extends State<IntensityScreen> {
//   List<String> minutes = ["10", "20", "30", "45"]; // = logic.getCurriculums();

//   @override
//   Widget build(BuildContext context) {
//     OnboardBloc oBlock = BlocProvider.of<OnboardBloc>(context);
//     // oBlock.add(OnboardInitialEvent("\"dd0b3181-57d3-11eb-99bc-0ad59f11d076\""));
//     String choosedCurr;
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
//         title: Text("Let's choose the curriculum",
//             style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: BlocProvider<OnboardBloc>(
//         create: (BuildContext context) {
//           return oBlock;
//         },
//         child: RefreshIndicator(
//           child:
//               BlocBuilder<OnboardBloc, OnboardState>(builder: (context, state) {
//             String selected;

//             if (state is OnboardInitial) {
//               print('us s${state.props}');
//             } else if (state is SelectCurriculumState) {
//               selected = state.selectId;
//             } else if (state is LoadCurriculumState) {
//               // curs = state.currs;
//             }
//             return Container(
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       itemCount: minutes.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onTap: () {
//                             choosedCurr = minutes[index];
//                             oBlock.add(OnboardChangeEvent(
//                               minutes[index],
//                             ));
//                           },
//                           child: minuteWidget(minutes[index], context,
//                               minutes[index] == selected),
//                         );
//                       },
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 3.0,
//                         crossAxisSpacing: 3.0,
//                       ),
//                     ),
//                   ),
//                   RaisedButton(
//                     child: Text("Next"),
//                     onPressed: () => {
//                       if (choosedCurr != null)
//                         {
//                           // oBlock.add(ChooseCurriculum(choosedCurr)),
//                           pushToScreen(context)
//                         }
//                     },
//                   )
//                 ],
//               ),
//             );
//           }),
//           onRefresh: () async {},
//         ),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }

// pushToScreen(BuildContext context) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//         builder: (_) => CareerScreen(
//             // user: this.user,
//             )),
//   );
// }

// Widget minuteWidget(String minute, BuildContext context, bool iselected) {
//   return Container(
//     child: Padding(
//       padding: EdgeInsets.all(10),
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           border: iselected
//               ? Border.all(color: Colors.purple)
//               : Border.all(color: Color.fromRGBO(248, 248, 249, 1)),
//           color: Color.fromRGBO(248, 248, 249, 1),
//         ),
//         child: Container(
//           margin: EdgeInsets.only(left: 25.0, top: 22.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Icon(Icons.check_circle_outline,
//                       color: iselected ? Colors.purple : Colors.grey),
//                   // imageWidget(),
//                 ],
//               ),
//               SizedBox(height: 35.0),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 4),
//                 child: Column(children: [
//                   Text(
//                     minute,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                       fontSize: 43.0,
//                     ),
//                     textAlign: TextAlign.right,
//                   ),
//                   Text(
//                     "min / day",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                       fontSize: 24.0,
//                     ),
//                   ),
//                 ]),
//               ),
//               SizedBox(height: 16.0),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
