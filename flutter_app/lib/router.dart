import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/chat/chat_room.dart';
import 'views/dashboard/dashboard.dart';
import 'views/home/home.dart';
import 'views/splash/splash_view.dart';

const String home = "/home";
const String splash = "/splash";
const String chatroom = "/chatroom";
const String dashboard = "/dashboard";

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(path: '/', builder: (BuildContext context, GoRouterState state) => const SplashView(),),
    GoRoute(path: splash, builder: (BuildContext context, GoRouterState state) => const SplashView(),),
    GoRoute(path: home, builder: (BuildContext context, GoRouterState state) => const HomeView()),
    GoRoute(path: chatroom, builder: (BuildContext context, GoRouterState state) => const ChatRoom()),
    GoRoute(path: dashboard, builder: (BuildContext context, GoRouterState state) => const DashboardWebView()),
  ],
);