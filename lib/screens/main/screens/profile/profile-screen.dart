import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/screens/main/screens/profile/bloc/profile_bloc.dart';
import 'package:tiny/screens/main/screens/profile/components/goal.dart';
import 'package:tiny/screens/main/screens/profile/components/user_info.dart';
import 'package:tiny/theme/style.dart';
import 'bloc/profile_bloc.dart';
import 'components/goal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/tempModels.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:fl_chart/fl_chart.dart';

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

// TabController _tabController = TabController(vsync: null, length: 3);
class ProfileScreen extends StatefulWidget {
  final bool isMe;

  const ProfileScreen({Key key, this.isMe = true}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;
  ScrollController _scrollController;
  final List<charts.Series> seriesList = _createSampleData();
  User user;

  var _momentValue = 2.0;
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _createSampleData();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener(_handleTabSelection);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
      });
      print("======= $_currentIndex");
    }
  }

  @override
  Widget build(BuildContext context) {
    final pBloc = BlocProvider.of<ProfileBloc>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // ProfileBloc pBloc = new ProfileBloc(userRepo);
    pBloc.add(LoadProfileEvent());
    return Scaffold(
      key: _drawerKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                authBloc.add(UserLoggedOut());
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: BlocProvider<ProfileBloc>(
        create: (BuildContext context) {
          pBloc.add(LoadProfileEvent());
          return pBloc;
        },
        child: RefreshIndicator(onRefresh: () async {
          pBloc.add(LoadProfileEvent());
        }, child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (BuildContext ctx, state) {
          if (state is ProfileLoadState) {
            this.user = state.user;
            return mainWidget(state.user, pBloc, 'creator');
          } else if (state is ProfileLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (state is ProfileSaveState) {
            pBloc.add(LoadProfileEvent());
          } else if (state is ProfileChangeRoleClickState) {
            return mainWidget(this.user, pBloc, 'creator');
          } else if (state is ProfileChangeRoleClickedState) {
            return mainWidget(this.user, pBloc, 'learner');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        })),
      )),
    );
  }

  Widget mainWidget(User user, ProfileBloc pBloc, String role) {
    return SingleChildScrollView(
      child: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Container(
          margin: EdgeInsets.only(left: 16.0.w, top: 16.0.h, right: 16.0.w),
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: UserInfo(
                  user: user,
                  role: role,
                  isMe: widget.isMe,
                  onTap: () => {
                    if (role == 'creator')
                      pBloc.add(ChangeRoleClickEvent())
                    else
                      pBloc.add(ChangeRoleClickedEvent())
                  },
                )),
                SliverPersistentHeader(
                  delegate: CustomSliverDelegate(_tabController, _currentIndex),
                  pinned: true,
                  floating: true,
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                postGridView(),
                goalGridView(),
                taggedGridView3(),
                taggedGridView3(),
                taggedGridView3(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget momentumGridView() {
    return Container(
      child: Text(''),
    );
  }

  // Tab 1 page (Frist TabView)
  Widget postGridView() {
    return Container(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            /* Center(
              child: RaisedButton(
                onPressed: () {
                  BlocProvider.of<SelectGoalBloc>(context).add(SelectGoalLoaded("\"dd0b3181-57d3-11eb-99bc-0ad59f11d076\"", (BlocProvider.of<AuthenticationBloc>(context).state as AuthenticationAuthenticated).user.id));
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => ExamScreen()));
                },
                child: Column(children: [
                  Container(
                    child: Text(
                      "Create goal",
                      style: GoogleFonts.openSans(),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  Icon(Icons.arrow_downward)
                ]),
              ),
            ),*/
            Container(
              margin: EdgeInsets.only(top: 30.h, left: 16.w),
              child: Text(
                "Momentum",
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16.w, top: 8.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      momentumItem(true),
                      momentumSeparator(lightGreen),
                      momentumItem(true),
                      momentumSeparator(lightGreen),
                      momentumItem(true),
                      momentumSeparator(ligtGrey2),
                      momentumItem(false),
                      momentumSeparator(ligtGrey2),
                      momentumEndItem('2x', false)
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Learn",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: dark),
                        ),
                        Text(
                          "Assessment",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: dark),
                        ),
                        Text(
                          "Priming",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: dark),
                        ),
                        Text(
                          "Gratitute",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: dark),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //'Learn', 'Assessment','Priming', 'Gratitude',
            Container(
              margin: EdgeInsets.only(top: 30.h, left: 16.w),
              child: Text(
                "Goal Progress",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.h, left: 16.w),
                  width: 118.w,
                  height: 118.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(199, 199, 204, 1),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(118.w)),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 8.h, bottom: 8.h, left: 8.w, right: 8.w),
                    width: 100.w,
                    height: 100.h,
                    child: CircularProgressIndicator(
                      value: 0.80,
                      backgroundColor: Colors.transparent,
                      valueColor: new AlwaysStoppedAnimation(lightGreen),
                      strokeWidth: 9,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            statsTitle("Today"),
                            Row(
                              children: [
                                Text(
                                  "36",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.openSans(
                                    color: Color.fromRGBO(37, 37, 37, 1),
                                    fontSize: 20,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("/45",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.openSans(
                                      color: Color.fromRGBO(37, 37, 37, 1),
                                      fontSize: 10,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 34.w,
                        ),
                        Column(
                          children: [
                            statsTitle('Momentum'),
                            stats("2x", Color(0xffef508b))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            statsTitle("Correct"),
                            stats("28", Color(0xff55c595))
                          ],
                        ),
                        SizedBox(
                          width: 34.w,
                        ),
                        Column(
                          children: [
                            statsTitle("Wrong"),
                            stats("8", Color(0xffed4656))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, left: 16.w),
              child: Text(
                "Activition",
              ),
            ),

            Container(
                margin: EdgeInsets.only(top: 12, left: 16.h, right: 16.h),
                padding: EdgeInsets.only(
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ligtGrey2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 120,
                width: ScreenUtil().screenWidth,
                // child:
                // Container(
                //     height: 200.h,
                // child: Expanded(
                // child: charts.BarChart(seriesList),
                child: LineChart(sampleData())
                // ),
                ),

            // ),
            // Expanded(
            //   child: Text('end'),
            // )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: GoogleFonts.openSans(
            color: Color(0xff72719b),
            fontWeight: FontWeight.w300,
            fontSize: 12,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'Mo';
              case 2:
                return 'Tu';
              case 3:
                return 'We';
              case 4:
                return 'Th';
              case 5:
                return 'Fr';
              case 6:
                return 'Sa';
              case 7:
                return 'Su';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          textStyle: TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return '';
          },
          margin: 8,
          reservedSize: 0,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 8,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(2, 2),
        FlSpot(3, 3),
        FlSpot(4, 2),
        FlSpot(5, 1.8),
        FlSpot(6, 2),
        FlSpot(7, 1.3),
      ],
      isCurved: true,
      colors: [
        lightGreen,
      ],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Color(0xFFD1D1D6)],
      ),
    );
    return [
      lineChartBarData1,
    ];
  }

  Expanded momentumSeparator(Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 1,
          right: 1,
        ),
        color: color,
        height: 2,
      ),
    );
  }

  Column momentumItem(bool isActive) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            child: SizedBox(
              width: 36,
              height: 36,
              child: isActive
                  ? Icon(
                      Icons.done,
                      color: lightGreen,
                    )
                  : Container(),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                  width: 3, color: isActive ? lightGreen : Color(0xFFD1D1D6)),
            ),
          ),
        ),
      ],
    );
  }

  Container momentumEndItem(String name, bool isActive) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(right: 28),
                child: ClipOval(
                  child: Container(
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: Container(
                          padding: EdgeInsets.all(6.0),
                          child: SvgPicture.asset(
                            "assets/svg/human.svg",
                            height: 12,
                            width: 12,
                            color: purple,
                          )),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      border: Border.all(
                          width: 3,
                          color: isActive ? Colors.green : Color(0xFFD1D1D6)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                  child: Text(name,
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  decoration: BoxDecoration(
                    color: lightPurple,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: lightPurple),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget statsTitle(String title) {
    return SizedBox(
      width: 58.w,
      child: Text(
        title,
        style: GoogleFonts.openSans(
          color: Color(0xff252525),
          fontSize: 10,
        ),
      ),
    );
  }

  Widget stats(value, color) {
    return SizedBox(
      width: 36.w,
      child: Text(
        value,
        style: GoogleFonts.openSans(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // Tab 2 page (Second TabView)
}
Widget goalGridView() {
    return Container(
      child: Column(
        children: Course()
            .getCourses()
            .map(
              (c) => Goal(
                course: c,
              ),
            )
            .toList(),
      ),
    );
    /* return Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 1,
        children: [
          ...createGoals()
        ],
      ),
    );*/
  }

List<Widget> createGoals() {
  List<Course> cs = new Course().getCourses();
  List<Widget> goals = [];
  cs.forEach((e) => {goals.add(Goal(course: e))});
  return goals;
}

Widget taggedGridView3() {
  return Container(
    margin: EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SAT MATH",
          style: GoogleFonts.openSans(
            color: ligtGrey,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
            ],
          ),
        ),
        Text(
          "SAT WRITING",
          style: GoogleFonts.openSans(
            color: ligtGrey,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
            ],
          ),
        ),
        Text(
          "SAT READING",
          style: GoogleFonts.openSans(
            color: ligtGrey,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
              Item(),
            ],
          ),
        )
      ],
    ),
  );
  return GridView.builder(
    itemCount: 4,
    padding: EdgeInsets.only(top: 4.0),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 3.0,
      crossAxisSpacing: 3.0,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/icon.png'),
          ),
        ),
      );
    },
  );
}

class Item extends StatelessWidget {
  const Item({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: ligtGrey2),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/test.jpg'),
        ),
      ),
      child: Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              color: new Color.fromRGBO(0, 0, 0, 0.3)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/hand.svg",
                        height: 12, width: 12),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      '75',
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

// Tab bar
class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  TabController _tabController;
  int _currentIndex;
  CustomSliverDelegate(this._tabController, this._currentIndex);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 44.0.h,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Color(0xff7851a2),
        labelColor: Color(0xff7851a2),
        tabs: <Widget>[
          Tab(
            icon: SvgPicture.asset(
              "assets/svg/bar_chart.svg",
              color: _currentIndex == 0 ? purple : ligtGrey2,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              "assets/svg/book.svg",
              color: _currentIndex == 1 ? purple : ligtGrey2,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              "assets/svg/hamburger.svg",
              color: _currentIndex == 2 ? purple : ligtGrey2,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              "assets/svg/file.svg",
              color: _currentIndex == 3 ? purple : ligtGrey2,
            ),
          ),
          Tab(
            icon: SvgPicture.asset(
              "assets/svg/bookmark.svg",
              color: _currentIndex == 4 ? purple : ligtGrey2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0.h;

  @override
  double get minExtent => 50.0.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
