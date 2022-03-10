import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/test_page.dart';
import 'package:my_med/src/modules/intro/pages/splash_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: TestPage),
    AutoRoute(page: SplashPage, path: '/splash', initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
