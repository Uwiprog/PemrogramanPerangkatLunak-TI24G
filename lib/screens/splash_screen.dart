import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.travel_explore, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'NusaTravel',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                // Menggunakan pushReplacementNamed agar kembali ke splash tidak bisa
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Mulai Eksplorasi', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}