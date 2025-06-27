import 'package:gemini/presentation/screens/chatiScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:gemini/presentation/screens/init_page.dart';

final appRouter = GoRouter(
initialLocation: '/InitPage',
routes: [
  GoRoute(path: '/InitPage', builder: (context, state) => InitPage()),
  GoRoute(path: '/ChatiScreen', builder: (context, state) => ChatiScreen()),
  
]
);