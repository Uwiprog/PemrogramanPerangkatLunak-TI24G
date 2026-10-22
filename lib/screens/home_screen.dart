import 'package:flutter/material.dart';
import '../models/tour_package.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<TourPackage> packages = [
    TourPackage(
      id: '1',
      title: 'Singapura City Explorer',
      description: 'Nikmati ikon modern Singapura seperti Marina Bay Sands, Gardens by the Bay, dan Universal Studios.',
      price: 5800000,
      imageUrl: 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?w=500',
    ),
    TourPackage(
      id: '2',
      title: 'Tokyo Cherry Blossom Trip',
      description: 'Jelajahi keindahan kota Tokyo, Gunung Fuji, serta tradisi budaya Jepang yang autentik.',
      price: 12500000,
      imageUrl: 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?w=500',
    ),
    TourPackage(
      id: '3',
      title: 'Seoul K-Pop & Heritage',
      description: 'Kunjungi istana tradisional Gyeongbokgung, pusat belanja Myeongdong, dan lokasi syuting drakor.',
      price: 9500000,
      imageUrl: 'https://plus.unsplash.com/premium_photo-1661936414165-3039a8d906f9?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D',
    ),
    TourPackage(
      id: '4',
      title: 'Bangkok-Pattaya Getaway',
      description: 'Wisata kuliner malam di Bangkok, belanja puas, dan menikmati pantai eksotis di Pattaya.',
      price: 4200000,
      imageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579365?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaTravel - Paket Luar Negeri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final pkg = packages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Image.network(
                pkg.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(pkg.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Rp ${pkg.price.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: pkg,
                );
              },
            ),
          );
        },
      ),
    );
  }
}