import 'package:flutter/material.dart';
import 'ui/kas/kas_view_model.dart';
import 'ui/kas/home_screen.dart';

void main() {
  runApp(const NusaKasApp());
}

class NusaKasApp extends StatelessWidget {
  const NusaKasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kasViewModel = KasViewModel();
    return MaterialApp(
      title: 'NusaKas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(viewModel: kasViewModel),
    );
  }
}