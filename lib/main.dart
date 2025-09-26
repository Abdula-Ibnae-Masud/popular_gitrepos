import 'package:flutter/material.dart';

import 'app_router.dart';
import 'dio_init/dio_injector.dart' as dio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dio.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final goRouter = AppRouter.router;

    return MaterialApp.router(
      title: 'Popular GitRepos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      // provide all router pieces from GoRouter instance
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,

      // optional but recommended for correct back-button behavior
      backButtonDispatcher: goRouter.backButtonDispatcher,
    );
  }
}
