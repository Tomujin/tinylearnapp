import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiny/screens/main/screens/activity/activity-unit.dart';
import 'package:tiny/screens/main/screens/activity/bloc/activity_bloc.dart';
import 'package:tiny/services/secure-storage.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  ActivityBloc _activityBloc;
  final SecureStorage _secureStorage = new SecureStorage();
  @override
  void initState() {
    _activityBloc = context.read<ActivityBloc>();
    _activityBloc.add(ActivityLoadEvent());
    super.initState();

    // _userRepo = context.read<UserRepository>();
  }

  @override
  Widget build(BuildContext context) {
    _activityBloc.add(ActivityLoadEvent());
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
            if (state is AcceptUserState)
              _activityBloc.add(ActivityLoadEvent());
            return Center(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 56,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Theme.of(context).primaryColor,
                      tabs: [
                        Tab(text: "Activity"),
                        Tab(text: "Chat"),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      if (state is ActivityLoadedState)
                        state.users.length == 0
                            ? Text("No activity")
                            : Column(
                                children: state.users
                                    .map((e) => ActivityUnitScreen(
                                          user: e,
                                          onPressed: () async {
                                            String userId = await _secureStorage
                                                .getSecureStore("userId");
                                            _activityBloc.add(
                                                UserAcceptEvent(userId, e.id));
                                          },
                                        ))
                                    .toList())
                      else
                        Text('loading'),
                      Icon(Icons.directions_transit),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
