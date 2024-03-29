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
    },
    DashboardRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const DashboardPage());
    },
    ForgetPasswordRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ForgetPasswordPage());
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ChangePasswordPage(key: args.key, email: args.email));
    },
    SettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SettingPage());
    },
    LanguageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LanguagePage());
    },
    AboutUsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const AboutUsPage());
    },
    NotificationRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NotificationPage());
    },
    DrugDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DrugDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: DrugDetailsPage(key: args.key, drugId: args.drugId));
    },
    DoctorsDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DoctorsDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: DoctorsDetailsPage(key: args.key, id: args.id));
    },
    ActivePrescriptionRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ActivePrescriptionPage());
    },
    ActivePrescriptionDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ActivePrescriptionDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ActivePrescriptionDetailsPage(
              key: args.key,
              activePrescriptionModel: args.activePrescriptionModel));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(TestRoute.name, path: '/'),
        RouteConfig(SplashRoute.name, path: '/splash'),
        RouteConfig(OnboardingRoute.name, path: '/on_boarding'),
        RouteConfig(LoginRoute.name, path: '/login'),
        RouteConfig(SignUpRoute.name, path: '/signup'),
        RouteConfig(DashboardRoute.name, path: '/dashboard'),
        RouteConfig(ForgetPasswordRoute.name, path: '/forget_password'),
        RouteConfig(ChangePasswordRoute.name,
            path: '/forget_password/change_password'),
        RouteConfig(SettingRoute.name, path: '/setting'),
        RouteConfig(LanguageRoute.name, path: '/language'),
        RouteConfig(AboutUsRoute.name, path: '/aboutUs'),
        RouteConfig(NotificationRoute.name, path: '/notification'),
        RouteConfig(DrugDetailsRoute.name, path: '/drug_detail'),
        RouteConfig(DoctorsDetailsRoute.name, path: '/doctor_detail'),
        RouteConfig(ActivePrescriptionRoute.name, path: '/active_prescription'),
        RouteConfig(ActivePrescriptionDetailsRoute.name,
            path: '/active_prescription_detail')
      ];
}

/// generated route for
/// [TestPage]
class TestRoute extends PageRouteInfo<void> {
  const TestRoute() : super(TestRoute.name, path: '/');

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

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: '/dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [ForgetPasswordPage]
class ForgetPasswordRoute extends PageRouteInfo<void> {
  const ForgetPasswordRoute()
      : super(ForgetPasswordRoute.name, path: '/forget_password');

  static const String name = 'ForgetPasswordRoute';
}

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({Key? key, required String email})
      : super(ChangePasswordRoute.name,
            path: '/forget_password/change_password',
            args: ChangePasswordRouteArgs(key: key, email: email));

  static const String name = 'ChangePasswordRoute';
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key, required this.email});

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: '/setting');

  static const String name = 'SettingRoute';
}

/// generated route for
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute() : super(LanguageRoute.name, path: '/language');

  static const String name = 'LanguageRoute';
}

/// generated route for
/// [AboutUsPage]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute() : super(AboutUsRoute.name, path: '/aboutUs');

  static const String name = 'AboutUsRoute';
}

/// generated route for
/// [NotificationPage]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute()
      : super(NotificationRoute.name, path: '/notification');

  static const String name = 'NotificationRoute';
}

/// generated route for
/// [DrugDetailsPage]
class DrugDetailsRoute extends PageRouteInfo<DrugDetailsRouteArgs> {
  DrugDetailsRoute({Key? key, required String drugId})
      : super(DrugDetailsRoute.name,
            path: '/drug_detail',
            args: DrugDetailsRouteArgs(key: key, drugId: drugId));

  static const String name = 'DrugDetailsRoute';
}

class DrugDetailsRouteArgs {
  const DrugDetailsRouteArgs({this.key, required this.drugId});

  final Key? key;

  final String drugId;

  @override
  String toString() {
    return 'DrugDetailsRouteArgs{key: $key, drugId: $drugId}';
  }
}

/// generated route for
/// [DoctorsDetailsPage]
class DoctorsDetailsRoute extends PageRouteInfo<DoctorsDetailsRouteArgs> {
  DoctorsDetailsRoute({Key? key, required String id})
      : super(DoctorsDetailsRoute.name,
            path: '/doctor_detail',
            args: DoctorsDetailsRouteArgs(key: key, id: id));

  static const String name = 'DoctorsDetailsRoute';
}

class DoctorsDetailsRouteArgs {
  const DoctorsDetailsRouteArgs({this.key, required this.id});

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'DoctorsDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [ActivePrescriptionPage]
class ActivePrescriptionRoute extends PageRouteInfo<void> {
  const ActivePrescriptionRoute()
      : super(ActivePrescriptionRoute.name, path: '/active_prescription');

  static const String name = 'ActivePrescriptionRoute';
}

/// generated route for
/// [ActivePrescriptionDetailsPage]
class ActivePrescriptionDetailsRoute
    extends PageRouteInfo<ActivePrescriptionDetailsRouteArgs> {
  ActivePrescriptionDetailsRoute(
      {Key? key, required ActivePrescriptionModel activePrescriptionModel})
      : super(ActivePrescriptionDetailsRoute.name,
            path: '/active_prescription_detail',
            args: ActivePrescriptionDetailsRouteArgs(
                key: key, activePrescriptionModel: activePrescriptionModel));

  static const String name = 'ActivePrescriptionDetailsRoute';
}

class ActivePrescriptionDetailsRouteArgs {
  const ActivePrescriptionDetailsRouteArgs(
      {this.key, required this.activePrescriptionModel});

  final Key? key;

  final ActivePrescriptionModel activePrescriptionModel;

  @override
  String toString() {
    return 'ActivePrescriptionDetailsRouteArgs{key: $key, activePrescriptionModel: $activePrescriptionModel}';
  }
}
