// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    TestRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const TestPage());
    },
    SplashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SplashPage());
    },
    OnboardingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const OnboardingPage());
    },
    LoginRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LoginPage());
    },
    SignUpRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SignUpPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        RouteConfig(TestRoute.name, path: '/test-page'),
        RouteConfig(SplashRoute.name, path: '/splash'),
        RouteConfig(OnboardingRoute.name, path: '/on_boarding'),
        RouteConfig(LoginRoute.name, path: '/login'),
        RouteConfig(SignUpRoute.name, path: '/signup')
      ];
}

/// generated route for
/// [TestPage]
class TestRoute extends PageRouteInfo<void> {
  const TestRoute() : super(TestRoute.name, path: '/test-page');

  static const String name = 'TestRoute';
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/splash');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute() : super(OnboardingRoute.name, path: '/on_boarding');

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/signup');

  static const String name = 'SignUpRoute';
}
