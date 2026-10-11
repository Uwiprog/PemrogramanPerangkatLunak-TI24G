class Book {
  final String id;
  final String nama;
  final String author;
  final double price;
  final String imageUrl;

  Book({
    required this.id,
    required this.nama,
    required this.author,
    required this.price,
    required this.imageUrl
  });
}

class CartItem{
  final String  id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity
  });
}