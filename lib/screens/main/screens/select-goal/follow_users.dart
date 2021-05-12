// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tiny/models/models.dart';
// import 'package:tiny/screens/main/screens/select-goal/bloc/onboard_bloc.dart';
// import 'package:tiny/screens/main/screens/select-goal/school_selection.dart';

// const assetName = 'assets/svg/tiny_name_logo.svg';

// class FollowUserScreen extends StatefulWidget {
//   const FollowUserScreen({Key key}) : super(key: key);

//   @override
//   _FollowUserScreenState createState() => _FollowUserScreenState();
// }

// class _FollowUserScreenState extends State<FollowUserScreen> {
//   List<User> curs; // = logic.getCurriculums();

//   @override
//   Widget build(BuildContext context) {
//     OnboardBloc oBlock = BlocProvider.of<OnboardBloc>(context);
//     oBlock.add(LoadUsersEvent());
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
//         title: Text(
//             "Let's follow tiny creators to \n create learning enviroment",
//             style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: BlocProvider<OnboardBloc>(
//         create: (BuildContext context) {
//           return oBlock;
//         },
//         child: RefreshIndicator(
//           child: BlocBuilder<OnboardBloc, SelectGoalState>(
//               builder: (context, state) {
//             String selected;

//             if (state is SelectGoalInitial) {
//               print('us s${state.props}');
//             } else if (state is SelectGoalSuccess) {
//               selected = state.selectedId;
//             } else if (state is LoadUsersState) {
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
//                           child: userInfo(
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
//                           //oBlock.add(ChooseCurriculumEvent(choosedCurr)),
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
//     MaterialPageRoute(builder: (_) => SchoolSelectionScreen()),
//   );
// }

// Widget userInfo(User user, BuildContext context, bool iselected) {
//   return Container(
//     //margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//     decoration: BoxDecoration(
//       // color: Colors.grey[50],
//       border: Border(
//         bottom: BorderSide(
//           color: Colors.black26,
//           width: 0.5,
//         ),
//       ),
//     ),
//     child: Container(
//       margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               userImageWithPlusIcon2(user),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     stats2('SAT', 0),
//                     stats2('Algebra', 5),
//                     stats2('Polynomy', 1),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             user.firstName == null ? "" : user.firstName,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 14.0,
//             ),
//           ),
//           SizedBox(height: 4.0),
//           RaisedButton(
//             child: Text("Follow"),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget stats2(String statName, int statCount) {
//   return Column(
//     children: <Widget>[
//       Text(
//         statName,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       // Text(statName),
//     ],
//   );
// }

// Widget userImageWithPlusIcon2(User user) {
//   return Stack(
//     children: <Widget>[
//       Container(
//         height: 65.0,
//         width: 65.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           border: Border.all(
//             color: Color.fromRGBO(120, 81, 162, 1),
//             style: BorderStyle.solid,
//             width: 2,
//           ),
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: (user.profilePic == null)
//                 ? AssetImage('assets/images/icon.png')
//                 : NetworkImage(user.profilePic),
//           ),
//         ),
//       ),
//     ],
//   );
// }
