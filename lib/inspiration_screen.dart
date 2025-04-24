import 'package:flutter/material.dart';
import '../news_service.dart';
import 'package:url_launcher/url_launcher.dart';

class InspirationScreen extends StatefulWidget {
  const InspirationScreen({super.key});

  @override
  _InspirationScreenState createState() => _InspirationScreenState();
}

class _InspirationScreenState extends State<InspirationScreen> {
  late Future<List<dynamic>> articles;

  @override
  void initState() {
    super.initState();
    articles = NewsService().fetchArticles(); // Using the same service
    // You could modify NewsService to have a fetchInspirationArticles() method
    // that uses different keywords like "success stories" or "overcoming abuse"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inspiration & Success Stories')),
      body: FutureBuilder<List<dynamic>>(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No inspiration stories found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(article['title'] ?? 'No Title', 
                      style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(article['source'] ?? 'Unknown Source'),
                    onTap: () {
                      final url = article['url'] ?? '';
                      if (url.isNotEmpty) {
                        launchUrl(Uri.parse(url)); // Open article link
                      }
                    }
                  )
                );
              },
            );
          }
        },
      ),
    );
  }
}