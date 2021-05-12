// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tiny/models/career.dart';
// import 'package:tiny/models/curriculum.dart';
// import 'package:tiny/screens/main/screens/select-goal/bloc/onboard_bloc.dart';
// import 'package:tiny/screens/main/screens/select-goal/follow_users.dart';
// import 'package:tiny/screens/main/screens/select-goal/school_selection.dart';

// const assetName = 'assets/svg/tiny_name_logo.svg';

// class CareerScreen extends StatefulWidget {
//   const CareerScreen({Key key}) : super(key: key);

//   @override
//   _CareerScreenState createState() => _CareerScreenState();
// }

// class _CareerScreenState extends State<CareerScreen> {
//   List<Career> curs; // = logic.getCurriculums();

//   @override
//   Widget build(BuildContext context) {
//     OnboardBloc oBlock = BlocProvider.of<OnboardBloc>(context);
//     oBlock.add(LoadCareerEvent());
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
//             } else if (state is LoadCareerState) {
//               curs = state.datas;
//             }
//             return Container(
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: curs == null ? 0 : curs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onTap: () {
//                             choosedCurr = curs[index].id;
//                             oBlock.add(OnboardChangeEvent(
//                               curs[index].id,
//                             ));
//                           },
//                           child: careers(
//                               curs[index], context, curs[index].id == selected),
//                         );
//                       },
//                     ),
//                   ),
//                   RaisedButton(
//                     child: Text("Next"),
//                     onPressed: () => {
//                       if (choosedCurr != null)
//                         {
//                           // oBlock.add(ChooseCurriculumEvent(choosedCurr)),
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
//     MaterialPageRoute(builder: (_) => FollowUserScreen()),
//   );
// }

// Widget careers(Career career, BuildContext context, bool iselected) {
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
//                 ],
//               ),
//               SizedBox(height: 60.0),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 4),
//                 child: Text(
//                   career.name,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 24.0,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//             ],
//           ),
//           // ),
//         ),
//       ),
//     ),
//   );
// }
