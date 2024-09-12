import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/onboard/onboard.dart';
import 'package:fork_and_fusion/features/presentation/pages/order_view/order_view.dart';
import 'package:fork_and_fusion/features/presentation/pages/product_view/product_view.dart';
import 'package:fork_and_fusion/features/presentation/pages/qr_pages.dart/qr_code_scanner.dart';
import 'package:fork_and_fusion/features/presentation/pages/search/search.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/sign_in/sign_in.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/signup/signup.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/splash_screen/splash_screen.dart';

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
          builder: (context) => const SignInPage(),
        );
      case '/signup':
        return MaterialPageRoute(
          builder: (context) => const SignUpPage(),
        );
      case '/bottomnav':
        return MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        );
      case '/qrscanner':
        return MaterialPageRoute(
          builder: (context) => const QRCodeScanner(),
        );
      case '/search':
        return MaterialPageRoute(
          builder: (context) => const Search(),
        );
      case '/productview':
        return MaterialPageRoute(
          builder: (context) => const ProductView(),
        );
      case '/orderview':
        if (args is bool) {
          return MaterialPageRoute(
            builder: (context) => OrderView(
              today: args,
            ),
          );
        }
        return errorRoutes();

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
