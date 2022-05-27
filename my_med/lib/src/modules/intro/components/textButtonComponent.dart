import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

Widget textButtonComponent({
  required BuildContext ctx,
  required PageRouteInfo<dynamic> route,
  required Widget child,
  Color? color,

}){
  return TextButton(
    onPressed: (){
       ctx.router.push(route);
    },
    child: child,
   );
}