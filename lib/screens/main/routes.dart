import 'package:tiny/screens/main/screens/activity/activity-screen.dart';
import 'package:tiny/screens/main/screens/discover/discover-screen.dart';
import 'package:tiny/screens/main/screens/home/home-screen.dart';
import 'package:tiny/screens/main/screens/profile/profile-screen.dart';
import 'package:tiny/screens/main/screens/story/stories-screen.dart';

final List<dynamic> routes = [
  {
    "index": 0,
    'text': "Home",
    'screen': HomeScreen(),
    'icon': "assets/svg/home.svg",
  },
  {
    "index": 1,
    'text': "Discover",
    'screen': StoriesScreen(),
    'icon': "assets/svg/discover.svg",
  },
  null,
  {
    "index": 3,
    'text': "Activity",
    'screen': ActivityScreen(),
    'icon': "assets/svg/gratitude.svg",
  },
  {
    "index": 4,
    'text': "Profile",
    'screen': ProfileScreen(),
    'icon': "assets/svg/profile.svg"
  },
];
