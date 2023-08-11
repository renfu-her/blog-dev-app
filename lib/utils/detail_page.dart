import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

// Copy the entire DetailPage class from the main file and paste it here.

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> article;

  const DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(article['image_url'], fit: BoxFit.cover),
              const SizedBox(height: 8.0),
              Html(
                data: article['content'],
                style: {
                  "pre": Style(
                    backgroundColor: Colors.grey[300],
                    color: Colors.black87,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
