import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../logger/FileOutputLogger.dart';
// import '../offline.dart';
import 'package:in307blog_flutter/services/blog_service.dart';
import 'package:in307blog_flutter/models/blog.dart';
import 'package:in307blog_flutter/screens/blog_edit_screen.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final BlogService _blogService = BlogService();
  late List<Blog> blogs;
  var logger = Logger(
    printer: PrettyPrinter(),
    output: FileOutputLogger(),
  );

  @override
  void initState() {
    super.initState();
    blogs = [];
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    try {
      final loadedBlogs = await _blogService.getAllBlogs();
      setState(() {
        blogs = loadedBlogs;
      });
    } catch (e) {
      logger.e('_loadBlogs() failed $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fehler. Die Blogs konnten nicht geladen werden. Bitte überprüfe dein Netzwerkverbindung.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Besuchte Länder Ki-Lian'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _loadBlogs(); // Blog Reload
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(blogs[index].id.toString()),
            onDismissed: (direction) {
              _deleteBlog(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: Text(blogs[index].title),
              subtitle: Text(blogs[index].description),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(blogs[index].image),
              ),
              onTap: () {
                _editBlog(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBlog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addBlog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(),
      ),
    );

    if (result != null && result is Blog) {
      await _blogService.createBlog(result);
      _loadBlogs();
    }
  }

  void _editBlog(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogEditScreen(
          blog: blogs[index],
        ),
      ),
    );

    if (result != null && result is Blog) {
      await _blogService.updateBlog(blogs[index].id, result);
      _loadBlogs();
    }
  }

  void _deleteBlog(int index) async {
    await _blogService.deleteBlog(blogs[index].id);
    _loadBlogs();
  }
}