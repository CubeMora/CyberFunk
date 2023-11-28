import 'package:flutter/material.dart';
import 'package:security_info_project/src/services/warn_up.dart';
import 'screen_reference.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return createRoute(FirstScreen());
      case '/main':
        return createRoute(const MainMenu());
      case '/test':
        return createRoute(const LoadScreen());
      case '/warm':
        return createRoute(const WarmUp());
      case '/blog':
        return createRoute(BlogListScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return BottomSheet(
          onClosing: () {
            Navigator.pop(context);
          },
          builder: (context) => const Text("Page or action not found."));
    });
  }

  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
