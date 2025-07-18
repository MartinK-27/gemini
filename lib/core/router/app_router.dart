import 'package:gemini/presentation/screens/addCultivo.dart';
import 'package:gemini/presentation/screens/chatiScreen.dart';
import 'package:gemini/presentation/screens/cultivoScreen.dart';
import 'package:gemini/presentation/screens/homeScreen.dart';
import 'package:gemini/presentation/screens/sensorScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:gemini/presentation/screens/init_page.dart';

final appRouter = GoRouter(
initialLocation: '/InitPage',
routes: [
  GoRoute(path: '/InitPage', builder: (context, state) => InitPage()),
  GoRoute(path: '/ChatiScreen', builder: (context, state) => ChatiScreen()),
  GoRoute(path: '/HomeScreen', builder: (context, state) => Homescreen()),
  GoRoute(path: '/CultivoScreen', builder: (context, state) => Cultivoscreen(),),
  GoRoute(path: '/SensorScreen', builder: (context, state) => Sensorscreen(),),
  GoRoute(path: '/AddcultivoScreen', builder: (context, state) => Addcultivo(),),
  
]
);