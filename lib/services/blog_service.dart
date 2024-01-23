import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import '../logger/FileOutputLogger.dart';
import '../models/blog.dart';
import 'package:in307blog_flutter/models/offline_db.dart';
import 'package:http/http.dart' as http;

class BlogService {
  // IP-Adresse des Servers
  final String baseUrl = 'http://192.168.0.12:3000/blog';
  final StoreRef<int, Map<String, dynamic>> _store =
  intMapStoreFactory.store('blogs');

  var logger = Logger(
    printer: PrettyPrinter(),
    output: FileOutputLogger(),
  );

  Future<List<Blog>> getAllBlogs() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final dbPath = await getApplicationDocumentsDirectory();
      final offlineDB = OfflineDB(path: dbPath.path + '/offline-blogs/database.db');

      // Download images
      await downloadImages(data, dbPath.path + '/images');

      // Löschen der Offline Datenbank
      await offlineDB.delDatabase();

      // Neue Offline Datenbank erstellen
      await offlineDB.createDatabase(data);
      logger.i('getAllBlogs() success HTTP-Code: ${response.statusCode}');
      return data.map((json) => Blog(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
      )).toList();
    } else {
      logger.e('getAllBlogs() failed HTTP-Code: ${response.statusCode}');
      throw Exception('Failed to load blogs');
    }
  }

  Future<void> createBlog(Blog blog) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': blog.title,
        'description': blog.description,
        'image': blog.image,
      }),
    );
    if (response.statusCode == 201) {
      logger.i('createBlog() success HTTP-Code: ${response.statusCode}');
    } else {
      logger.e('createBlog() failed HTTP-Code: ${response.statusCode} ${response.body}');
    }
  }

  Future<void> updateBlog(int id, Blog blog) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': blog.title,
          'description': blog.description,
          'image': blog.image,
        }),
      );
      if (response.statusCode == 200) {
        logger.i('updateBlog() success HTTP-Code: ${response.statusCode}');
      } else {
        logger.w('updateBlog() failed HTTP-Code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      logger.e('updateBlog() failed HTTP-Code: ${e.toString()}');
    }
  }

  Future<void> deleteBlog(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      logger.i('deleteBlog() success HTTP-Code: ${response.statusCode}');
    } else {
      logger.e('deleteBlog() failed HTTP-Code: ${response.statusCode}');
    }
  }

  // @todo: Noch implementieren
  Future<void> downloadImages(List<dynamic> data, String safePath) async {
    for (var blog in data) {
      final imageUrl = blog['image'];
      print(imageUrl);
      print(safePath);
    }
  }
}