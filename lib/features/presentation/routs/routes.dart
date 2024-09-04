import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/onboard/onboard.dart';
import 'package:fork_and_fusion/features/presentation/pages/sign_in/sign_in.dart';
import 'package:fork_and_fusion/features/presentation/pages/splash_screen/splash_screen.dart';

class Routes {
  static Route<dynamic>? routes(RouteSettings s) {
    var args = s.arguments;
    switch (s.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/onboard':
        return MaterialPageRoute(
          builder: (context) => const Onboard(),
        );
      case '/signin':
       return MaterialPageRoute(
          builder: (context) =>const SignInPage(),
        );


      default:
        return errorRoutes();
    }
  }

  static Route<dynamic>? errorRoutes() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
