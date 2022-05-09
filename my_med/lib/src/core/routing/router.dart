import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_med/src/core/test_page.dart';
import 'package:my_med/src/modules/dashboard/pages/dashboard_page.dart';
import 'package:my_med/src/modules/intro/pages/login.dart';
import 'package:my_med/src/modules/intro/pages/onboarding.dart';
import 'package:my_med/src/modules/intro/pages/signup.dart';
import 'package:my_med/src/modules/intro/pages/splash_page.dart';
import 'package:my_med/src/modules/intro/pages/forget_password.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: TestPage, initial: (kDebugMode) ? true : false),
    AutoRoute(page: SplashPage, path: '/splash', initial: (kDebugMode) ? false : true),
    AutoRoute(page: OnboardingPage, path: '/on_boarding'),
    AutoRoute(page: LoginPage, path: '/login'),
    AutoRoute(page: SignUpPage, path: '/signup'),
    AutoRoute(page: DashboardPage, path: '/dashboard'),
    AutoRoute(page: ForgetPasswordPage, path: '/forget_password'),
  ],
)
class AppRouter extends _$AppRouter {}
