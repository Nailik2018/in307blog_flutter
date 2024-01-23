import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../logger/FileOutputLogger.dart';
import '../models/blog.dart';

class BlogEditScreen extends StatefulWidget {
  final Blog? blog;

  BlogEditScreen({this.blog});

  @override
  _BlogEditScreenState createState() => _BlogEditScreenState();
}

class _BlogEditScreenState extends State<BlogEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  var logger = Logger(
    printer: PrettyPrinter(),
    output: FileOutputLogger(),
  );


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.blog?.description ?? '');
    _imageController =
        TextEditingController(text: widget.blog?.image ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog == null ? 'Neuen Blog erstellen' : 'Blog bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titel'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Beschreibung'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Bild-URL'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveBlog();
              },
              child: Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBlog() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final image = _imageController.text;
    if (title.isNotEmpty && description.isNotEmpty && image.isNotEmpty) {
      logger.i('_saveBlog() success');
      Navigator.pop(
        context,
        Blog(id: widget.blog?.id ?? 0, title: title, description: description, image: image),
      );
    }
  }
}