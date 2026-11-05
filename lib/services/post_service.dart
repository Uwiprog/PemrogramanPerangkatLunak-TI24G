import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // 1. GET: Mengambil daftar post/pengumuman
  Future<List<Post>> fetchPosts() async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data pengumuman (Status: ${response.statusCode})');
    }
  }

  // 2. GET: Mengambil komentar berdasarkan ID post
  Future<List<Comment>> fetchComments(int postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat komentar');
    }
  }

  // 3. POST: Menambahkan pengumuman baru menggunakan jsonEncode
  Future<Post> createPost(Post post) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal menambahkan pengumuman baru');
    }
  }
}