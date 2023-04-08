import 'package:flutter/material.dart';
import 'package:onellapp2/screens/home.dart';
import 'package:onellapp2/screens/settings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onellapp2/utils/constants.dart' as constants;
import 'package:go_router/go_router.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: 'Onell');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsPage(title: 'Informations');
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    // initialisation des data local si jamais init
    if (box.read(constants.name) == null || box.read(constants.name) == '') {
      box.write(constants.name, 'Alexis');
      box.write(constants.nameai, 'Onell');
      box.write(constants.xp, '10');
      box.write(constants.food, 50);
      box.write(constants.shower, 25);
      box.write(constants.sleep, 100);
    }

    return MaterialApp.router(
      routerConfig: _router,
    );

  }
}
