import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_providers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Keranjang Anda masih kosong!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final bookId = cartProvider.items.keys.firstWhere(
                        (k) => cartProvider.items[k] == item,
                      );

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          title: Text(
                            item.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Rp ${item.price.toStringAsFixed(0)} x ${item.quantity} = Rp ${(item.price * item.quantity).toStringAsFixed(0)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Tombol Kurang (-)
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  cartProvider.removeItem(bookId);
                                },
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Tombol Tambah (+) - DIPERBAIKI
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.indigo,
                                ),
                                onPressed: () {
                                  // Kita buat ulang objek Book sederhana berdasarkan data item keranjang saat ini
                                  final book = Book(
                                    id: bookId,
                                    nama: item.title,
                                    author: '', // Tidak masalah kosong untuk penambahan di keranjang
                                    price: item.price,
                                    imageUrl: item.imageUrl,
                                  );
                                  cartProvider.addItem(book);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Pembayaran:',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Rp ${cartProvider.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        onPressed: cartItems.isEmpty
                            ? null
                            : () {
                                cartProvider.clearCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Checkout Berhasil! Terima kasih.',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
