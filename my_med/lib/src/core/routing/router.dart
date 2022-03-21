import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/test_page.dart';
import 'package:my_med/src/modules/dashboard/pages/dashboard_page.dart';
import 'package:my_med/src/modules/intro/pages/login.dart';
import 'package:my_med/src/modules/intro/pages/onboarding.dart';
import 'package:my_med/src/modules/intro/pages/signup.dart';
import 'package:my_med/src/modules/intro/pages/splash_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: TestPage),
    AutoRoute(page: SplashPage, path: '/splash', initial: true),
    AutoRoute(page: OnboardingPage, path: '/on_boarding'),
    AutoRoute(page: LoginPage, path: '/login'),
    AutoRoute(page: SignUpPage, path: '/signup'),
    AutoRoute(page: DashboardPage, path: '/dashboard'),
  ],
)
class AppRouter extends _$AppRouter {}
