import 'package:flutter/foundation.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier{
  final List<Book> _books = [
    Book(
      id: '1',
      nama: 'Begining Flutter 3.0 with Dart',
      author: 'Sanjib Sinha',
      price: 300000,
      imageUrl: 'assets/flutter_book.jpg'
    ),
    Book(
      id: '2',
      nama: 'Fundamentals of Sosftware Architecture',
      author: 'Mark Richards and Neal Ford',
      price: 279000,
      imageUrl: 'assets/FSA.jpg'
    ),
    Book(
      id: '3',
      nama: 'Intelligent IoT System',
      author: 'Sumit Singha Chowdhury, Hanamant Jakaraddi, and Ratnakirti Roy',
      price: 370000,
      imageUrl: 'assets/IoT.png'
    ),
    Book(
      id: '4',
      nama: 'Computer Coding Pythin Games for Kids',
      author: 'Carol Vorderman',
      price: 99000,
      imageUrl: 'assets/Python.png'
    ),
  ];
  List<Book> get books => _books;

  void addBook(Book newBook) {
    _books.add(newBook);
    notifyListeners();
  }
}