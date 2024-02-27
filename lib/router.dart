import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/top.dart';
import '../view/janken.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'top',
      path: '/',
      builder: (context, state) {
        return const TopPage();
      },
    ),
    GoRoute(
      name: 'janken',
      path: '/janken',
      builder: (context, state) {
        return const JankenPage();
      },
    ),
  ],
);
