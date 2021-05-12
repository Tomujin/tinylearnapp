import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/blocs/login/login_bloc.dart';
import 'package:tiny/constants/api.dart';
import 'package:tiny/resources/authentication-repository.dart';
import 'package:tiny/resources/post-repository.dart';
import 'package:tiny/resources/selectGoal-repository.dart';
import 'package:tiny/resources/story-repository.dart';
import 'package:tiny/resources/user-repository.dart';
import 'package:tiny/screens/main/components/community/bloc/community_bloc.dart';
import 'package:tiny/screens/main/screens/activity/bloc/activity_bloc.dart';
import 'package:tiny/screens/main/screens/home/blocs/comment/comment_bloc.dart';
import 'package:tiny/screens/main/screens/home/blocs/post/post_bloc.dart';
import 'package:tiny/screens/main/screens/home/blocs/reaction/reaction_bloc.dart';
import 'package:tiny/screens/main/screens/home/blocs/story/story_bloc.dart';
import 'package:tiny/screens/main/screens/profile/bloc/profile_bloc.dart';
import 'package:tiny/screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';
import 'package:tiny/screens/splash/splash-screen.dart';
import 'package:tiny/services/graphql.dart';
import 'package:tiny/theme/style.dart';
import 'package:uni_links/uni_links.dart';

import 'screens/main/screens/select-goal/bloc/selectGoal_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
      builder: () => App()));
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ValueNotifier<GraphQLClient> client;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      client = clientFor(uri: ApiConfig.apiHost, navigatorKey: navigatorKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    // printScreenInformation();

    AuthencationRepository authRepo = AuthencationRepository();

    UserRepository userRepo = UserRepository(client.value);
    //ignore: close_sinks
    AuthenticationBloc authBloc = AuthenticationBloc(authRepo, userRepo)
      ..add(AppLoaded());
    LoginBloc loginBloc =
        LoginBloc(authBloc: authBloc, authRepo: authRepo, userRepo: userRepo);

    return GraphQLProvider(
      client: client,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthencationRepository>(
            create: (BuildContext ctx) {
              return authRepo;
            },
          ),
          RepositoryProvider<UserRepository>(
            create: (ctx) {
              return userRepo;
            },
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthenticationBloc>(create: (BuildContext ctx) {
            return authBloc;
          }),
          BlocProvider<LoginBloc>(create: (BuildContext ctx) {
            //ignore: close_sinks
            return loginBloc;
          }),
        ], child: TinyApp(client)),
      ),
    );
  }

  void printScreenInformation() {
    print('Device width: ${1.sw}dp');
    print('Device height: ${1.sh}dp');
    print('Device pixel density: ${ScreenUtil().pixelRatio}');
    print('BottomBar height: ${ScreenUtil().bottomBarHeight}dp');
    print('StatusBar height: ${ScreenUtil().statusBarHeight}dp');
    print(
        'The ratio of actual width dp to design draft px: ${ScreenUtil().scaleWidth}');
    print(
        'The ratio of actual height dp to design draft px: ${ScreenUtil().scaleHeight}');
    print(
        'Width and font enlargement ratio relative to the design draft: ${ScreenUtil().scaleWidth * ScreenUtil().pixelRatio}');
    print(
        'Height relative to the magnification ratio of the design draft: ${ScreenUtil().scaleHeight * ScreenUtil().pixelRatio}');
    print('System font scaling: ${ScreenUtil().textScaleFactor}');
    print('0.5 of screen width: ${0.5.sw}dp');
    print('0.5 of screen height: ${0.5.sh}dp');
  }
}

class TinyApp extends StatelessWidget {
  final _client;
  TinyApp(this._client);

  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = UserRepository(_client.value);
    ProfileBloc profileBloc = ProfileBloc(_userRepository);
    ActivityBloc activityBloc = ActivityBloc(_userRepository);

    StoryRepository storyRepo = StoryRepository(_client.value);
    SelectGoalRepository selectGoalRepo = SelectGoalRepository(_client.value);
    SelectGoalBloc selectGoalBloc =
        SelectGoalBloc(selectGoalRepository: selectGoalRepo);

    PostRepository postRepo = PostRepository(_client.value);

    CommentBloc postCommentBloc = CommentBloc(postsRepository: postRepo);
    CommunityBloc communityBloc = CommunityBloc(_userRepository);
    ReactionBloc reactionBloc = ReactionBloc(postsRepository: postRepo);
    StoryBloc storyBloc = StoryBloc(storiesRepository: storyRepo);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostRepository>(
          create: (BuildContext ctx) {
            return postRepo;
          },
        ),
        RepositoryProvider<StoryRepository>(create: (BuildContext ctx) {
          return storyRepo;
        }),
        RepositoryProvider<SelectGoalRepository>(
          create: (BuildContext ctx) {
            return selectGoalRepo;
          },
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<PostBloc>(
              create: (context) => PostBloc(
                  postsRepository: postRepo,
                  // storiesRepository: storyRepo,
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context)),
            ),
            BlocProvider<CommunityBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return communityBloc;
            }),
            BlocProvider<SelectGoalBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return selectGoalBloc;
            }),
            BlocProvider<ProfileBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return profileBloc;
            }),
            BlocProvider<CommentBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return postCommentBloc;
            }),
            BlocProvider<ReactionBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return reactionBloc;
            }),
            BlocProvider<StoryBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return storyBloc;
            }),
            BlocProvider<ActivityBloc>(create: (BuildContext ctx) {
              //ignore: close_sinks
              return activityBloc;
            })
          ],
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return MaterialApp(
                title: 'Tiny',
                theme: appTheme(),
                home: StreamBuilder(
                  stream: getLinksStream(),
                  builder: (context, snapshot) {
                    print("main state ${state}");
                    // our app started by configured links
                    if (snapshot.hasData) {
                      print("snapshot:${snapshot.data}");

                      if (state is AuthenticationNotAuthenticated) {
                        var uri = Uri.parse(snapshot.data);
                        final queryParams = uri.queryParameters;
                        if (uri.hasQuery &&
                            uri.queryParameters.containsKey("code")) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(AuthCodeReceived(code: queryParams['code']));
                        }
                        print(uri.queryParametersAll.entries.toList());
                      }
                    }
                    return SplashScreen();
                  },
                ));
          })),
    );
  }
}
