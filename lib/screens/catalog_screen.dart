import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_providers.dart';
import '../providers/book_providers.dart';
import '../providers/cart_providers.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final books = bookProvider.books;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore - M.Dwi Haryanto (20240040174)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Tambahkan di dalam actions: [ ... ] pada AppBar catalog_screen.dart

          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          // Tombol menuju Keranjang Belanja dengan Badge Total Item
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              if (cartProvider.totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cartProvider.totalItems}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Gambar / Placeholder Buku
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      book.imageUrl,
                      width: 60,
                      height: 80,
                      fit: BoxFit.cover,
                      // Fallback jika gambar gagal dimuat
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.indigo[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.book,
                            size: 30,
                            color: Colors.indigo,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(right: 5)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.nama,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Penulis: ${book.author}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Rp ${book.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tombol Tambah ke Keranjang
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      cartProvider.addItem(book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${book.nama} berhasil ditambahkan!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('add to cart'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
