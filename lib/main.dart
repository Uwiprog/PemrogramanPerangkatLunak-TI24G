// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/book_providers.dart';
import 'providers/cart_providers.dart';
import 'providers/theme_providers.dart'; // <-- Import ThemeProvider
import 'screens/catalog_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // <-- Daftarkan di sini
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendengarkan perubahan dari ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'NusaBookstore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeProvider.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Menerapkan tema secara global
      home: const CatalogScreen(),
    );
  }
}
