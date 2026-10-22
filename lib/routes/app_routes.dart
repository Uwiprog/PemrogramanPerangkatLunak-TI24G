import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/not_found_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String booking = '/booking';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        home: (context) => HomeScreen(),
        detail: (context) => const DetailScreen(),
        booking: (context) => const BookingScreen(),
      };

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
      settings: settings,
    );
  }
}