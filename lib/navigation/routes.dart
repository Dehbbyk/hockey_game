// import 'dart:core';
//
// import 'package:flutter/material.dart';
//
//
// enum Routes {
//   main('/'),
//   game('/game'),
//   leaderboard('/leaderboard');
//
//   final String route;
//
//   const Routes(this.route);
//
//   static Route routes(RouteSettings settings) {
//     MaterialPageRoute buildRoute(Widget widget) {
//       return MaterialPageRoute(builder: (_) => widget, settings: settings);
//     }
//
//     final routeName = Routes.values.firstWhere((e) => e.route == settings.name);
//
//     switch (routeName) {
//       case Routes.main:
//         return buildRoute(const MainMenuScreen());
//       case Routes.game:
//         return buildRoute(const MyGameWidget());
//       case Routes.leaderboard:
//         return buildRoute(const LeaderboardScreen());
//       default:
//         throw Exception('Route does not exists');
//     }
//   }
// }
//
// extension BuildContextExtension on BuildContext {
//   void pushAndRemoveUntil(Routes route) {
//     Navigator.pushNamedAndRemoveUntil(this, route.route, (route) => false);
//   }
//
//   void push(Routes route) {
//     Navigator.pushNamed(this, route.route);
//   }
// }
