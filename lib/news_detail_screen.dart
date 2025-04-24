import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final dynamic article;
  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['source']['name'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']),
            SizedBox(height: 10),
            Text(article['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(article['description'] ?? 'No Description'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse(article['url']));
              },
              child: Text('Read Full Article'),
            ),
          ],
        ),
      ),
    );
  }
}