import 'package:go_router/go_router.dart';
import 'package:gemini/presentation/screens/home_page.dart';
import 'package:gemini/presentation/screens/init_page.dart';

final appRouter = GoRouter(
initialLocation: '/InitPage',
routes: [
  GoRoute(path: '/InitPage', builder: (context, state) => InitPage()),
  GoRoute(path: '/HomePage', builder: (context, state) => HomePage()),
  
]
);