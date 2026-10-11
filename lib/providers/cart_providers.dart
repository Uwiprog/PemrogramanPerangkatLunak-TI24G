import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  // 1. Menghitung jumlah seluruh buku (totalItems)
  int get totalItems {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  // 2. Menghitung total harga keseluruhan (totalPrice)
  double get totalPrice {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // 3. Fungsi addItem() - Menambah buku atau menambah jumlah jika sudah ada
  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      _items.update(
        book.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        book.id,
        () => CartItem(
          id: book.id,
          title: book.nama,
          price: book.price,
          imageUrl: book.imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners(); // Wajib dipanggil agar UI memperbarui state
  }

  // 4. Fungsi removeItem() - Mengurangi jumlah atau menghapus buku
  void removeItem(String bookId) {
    if (!_items.containsKey(bookId)) return;

    if (_items[bookId]!.quantity > 1) {
      _items.update(
        bookId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(bookId);
    }
    notifyListeners();
  }

  // 5. Fungsi clearCart() - Mengosongkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}