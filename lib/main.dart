import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const NusaTravelApp());
}

class NusaTravelApp extends StatelessWidget {
  const NusaTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaTravel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      onUnknownRoute: AppRoutes.onUnknownRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}