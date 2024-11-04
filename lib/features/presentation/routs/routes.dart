import 'package:flutter/material.dart';
import 'package:fork_and_fusion/features/domain/entity/order_entity.dart';
import 'package:fork_and_fusion/features/domain/entity/product.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/history/pages/picked_data.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/pages/about_the_app.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/pages/contact_us.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/pages/favourite.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/pages/privacy_policy.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/pages/terms_of_service.dart';
import 'package:fork_and_fusion/features/presentation/pages/intro_pages/onboard/onboard.dart';
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
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/onboard':
        return MaterialPageRoute(builder: (context) => const Onboard());
      case '/signin':
        return MaterialPageRoute(builder: (context) => const SignInPage());
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/bottomnav':
        if (args is int) {
          return MaterialPageRoute(
              builder: (context) => BottomNavBar(
                    currentPage: args,
                  ));
        }
        return errorRoutes();

      case '/qrscanner':
        return MaterialPageRoute(builder: (context) => QRCodeScanner());
      case '/search':
        return MaterialPageRoute(builder: (context) => Search());
      case '/productview':
        if (args is ProductEntity) {
          return MaterialPageRoute(
              builder: (context) => ProductView(product: args));
        } else if (args is Map) {
          return MaterialPageRoute(
              builder: (context) => ProductView(
                    product: args['product'],
                    fromCart: args['from'] ?? false,
                    cart: args['cart'],
                  ));
        }
        return errorRoutes();

      case '/orderview':
        if (args is OrderEntity) {
          return MaterialPageRoute(
            builder: (context) => OrderView(order: args),
          );
        }
        return errorRoutes();
      case '/favourite':
        return MaterialPageRoute(builder: (context) => const Favourite());
      case '/privacy policy':
        return MaterialPageRoute(builder: (context) => const PrivacyPolicy());
      case '/terms of service':
        return MaterialPageRoute(builder: (context) => const TermsOfService());
      case '/about the app':
        return MaterialPageRoute(builder: (context) => const AboutApp());
      case '/contact us':
        return MaterialPageRoute(builder: (context) => const ContactUs());
      case '/picked datapage':
        if (args is List<OrderEntity>) {
          return MaterialPageRoute(
              builder: (context) => PickedDataPage(orders: args));
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
