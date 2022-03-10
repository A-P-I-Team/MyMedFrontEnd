import 'package:flutter/material.dart';
import 'package:my_med/src/core/routing/router.dart';

class MyMed extends StatelessWidget {
  final _appRouter = AppRouter();

  MyMed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Med',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xFF47BAEB)),
        appBarTheme: const AppBarTheme(
          foregroundColor: Color(0xFF909090),
          backgroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.w400,
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
          ),
          bodyText2: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle1: TextStyle(
            color: Color(0xFF909090),
            fontWeight: FontWeight.w400,
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle2: TextStyle(
            color: Color(0xFF47BAEB),
            fontWeight: FontWeight.w700,
            fontSize: 12,
            overflow: TextOverflow.ellipsis,
          ),
          headline1: TextStyle(
            color: Color(0xFF474747),
            fontWeight: FontWeight.w700,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
