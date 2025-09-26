import 'package:go_router/go_router.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/details_page.dart';
import 'data/repositories/repository.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
        path: '/details',
        builder: (context, state) {
          final repo = state.extra as Repository;
          return DetailsPage(repository: repo);
        },
      ),
    ],
  );
}
