import 'package:flutter/material.dart';

import 'auth/loginscreen.dart';
import 'auth/signup.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(),
      );
  }
}
