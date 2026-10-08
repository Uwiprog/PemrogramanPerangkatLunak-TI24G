import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Flutter Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductProfilePage(),
    );
  }
}

class ProductProfilePage extends StatelessWidget {
  const ProductProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('PPM Sesi 2 - M.Dwi Haryanto (20240040174)'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // 1. Kartu Profil Mahasiswa (StatelessWidget)
            ProfileCardWidget(),
            SizedBox(height: 20),
            
            // 2. Banner Promo menggunakan Stack & Positioned
            PromoBannerWidget(),
            SizedBox(height: 20),

            // 3. Kartu Produk (StatefulWidget)
            ProductCardWidget(),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// 1. WIDGET PROFIL MAHASISWA (StatelessWidget)
// ----------------------------------------------------------------
class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Foto Profil (bisa diganti AssetImage jika file 'assets/profil.jpg' sudah siap)
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/profil.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nama: M.Dwi Haryanto',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'NIM: 20240040174',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              'Prodi/Kelas: Teknik Informatika / TI24G',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // 5 Ikon Bintang
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------
// 2. WIDGET BANNER PROMO (Stack & Positioned)
// ----------------------------------------------------------------
class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          // Background Banner Container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          // Teks Promo di tengah/kiri
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PROMO SPESIAL HARI INI!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Diskon 50% untuk semua produk pilihan developer.',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          // Posisi Badge Diskon menggunakan Positioned
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'DISKON 50%',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------
// 3. WIDGET KARTU PRODUK (StatefulWidget)
// ----------------------------------------------------------------
class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({super.key});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  bool isFavorite = false;
  int likeCount = 120;
  int quantity = 1;
  final double basePrice = 150000;

  // Daftar 3 foto produk dari folder assets
  final List<String> productImages = [
    'assets/atas.jpg',
    'assets/atasbox.jpg',
    'assets/samping.jpg',
  ];

  int _currentIndex = 0;
  
  // Controller untuk mengatur perpindahan halaman PageView via tombol
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Fungsi pindah ke gambar berikutnya (Next)
  void _nextImage() {
    if (_currentIndex < productImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Jika sudah di foto terakhir, kembali ke foto pertama (looping)
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Fungsi pindah ke gambar sebelumnya (Back)
  void _prevImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Jika di foto pertama, lompat ke foto terakhir
      _pageController.animateToPage(
        productImages.length - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        likeCount++;
      } else {
        likeCount--;
      }
    });
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = basePrice * quantity;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SLIDER GAMBAR DENGAN TOMBOL NEXT / BACK (STACK)
            Stack(
              alignment: Alignment.center,
              children: [
                // Area PageView Foto
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: productImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          productImages[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

                // Tombol Back (Kiri)
                Positioned(
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                      onPressed: _prevImage,
                    ),
                  ),
                ),

                // Tombol Next (Kanan)
                Positioned(
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                      onPressed: _nextImage,
                    ),
                  ),
                ),

                // Indikator Titik (Dots) di bagian bawah dalam Stack
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      productImages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _currentIndex == index ? 12 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? Colors.deepPurple : Colors.white70,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Kategori dan Tombol Favorite (Row)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kategori: Elektronik & Software',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                    Text('$likeCount', style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            
            const Text(
              'Semi Mechanical Mini Keyboard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              'Harga Satuan: Rp ${basePrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: Rp ${totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jumlah Pembelian:', style: TextStyle(fontSize: 14)),
                Row(
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Berhasil memasukkan $quantity produk ke keranjang!',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}