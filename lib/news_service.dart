/*
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
    // final String apiKey = 'ec3843ff73e347aa95fbab40c1a4250e'; 
    // final String apiUrl = 'https://newsapi.org/v2/everything?q=domestic%20abuse%20survivor%20stories&language=en&apiKey=';
    final String apiKey = 'ec3843ff73e347aa95fbab40c1a4250e'; 
    // final String apiUrl = 'https://newsapi.org/v2/everything?q=domestic%20violence%20India&language=en&apiKey=';// apiKey ;
    // final String apiUrl = 'https://newsapi.org/v2/everything?q=domestic%20abuse%20laws%20India&language=en&apiKey='; // + apiKey;
    final String apiUrl = 'https://newsapi.org/v2/everything?q=domestic%20voilence&language=en&sources=the-times-of-india,the-hindu,deccan-herald,ndtv,india-today,hindustan-times,financial-express&apiKey=';
  Future<List<dynamic>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl + apiKey));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load articles');
    }
  }
} 
*/

/*import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String newsApiKey = 'ec3843ff73e347aa95fbab40c1a4250e';
  //final String newsDataApiKey = 'your_newsdata_api_key';
  final String mediaStackApiKey = 'c4766a61650b9a8a896e28221fd11e19';
  final String gNewsApiKey = '9808b7534d3e4fcd9ff8a2a629de37b9';

  final String newsApiUrl = 'https://newsapi.org/v2/everything?q=domestic%20violence%20India&language=en&sources=the-times-of-india,the-hindu,deccan-herald,ndtv,india-today,hindustan-times,financial-express&apiKey=';
  //final String newsDataUrl = 'https://newsdata.io/api/1/news?apikey=';
  final String mediaStackUrl = 'http://api.mediastack.com/v1/news?access_key=';
  final String gNewsUrl = 'https://gnews.io/api/v4/search?q=domestic%20violence%20India&token=';

  Future<List<dynamic>> fetchArticles() async {
    try {
      final responses = await Future.wait([
        http.get(Uri.parse(newsApiUrl + newsApiKey)),
        http.get(Uri.parse(newsDataUrl + newsDataApiKey + '&q=domestic%20abuse%20India%20OR%20domestic%20violence%20India&country=in&language=en')),
        http.get(Uri.parse(mediaStackUrl + mediaStackApiKey + '&keywords=domestic%20abuse%20India,domestic%20violence%20India&countries=in&languages=en')),
        http.get(Uri.parse(gNewsUrl + gNewsApiKey + '&q=domestic%20abuse%20India&lang=en&country=in'))
      ]);

      List<dynamic> articles = [];

      for (var response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          if (data.containsKey('articles')) {
            articles.addAll(data['articles']); // NewsAPI & GNews
          } else if (data.containsKey('data')) {
            articles.addAll(data['data']); // NewsData.io & Mediastack
          }
        }
      }

      return articles;
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
*/

/*
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  // Declare API Keys
  final String newsApiKey = 'ec3843ff73e347aa95fbab40c1a4250e';
  final String newsDataApiKey = 'your_newsdata_api_key';
  final String mediaStackApiKey = 'c4766a61650b9a8a896e28221fd11e19';
  final String gNewsApiKey = '9808b7534d3e4fcd9ff8a2a629de37b9';
  
  // Declare API URLs
  final String newsApiUrl = 'https://newsapi.org/v2/everything?q=domestic%20violence&language=en&sources=the-times-of-india,the-hindu,deccan-herald,ndtv,india-today,hindustan-times,financial-express&apiKey=';
  final String newsDataUrl = 'https://newsdata.io/api/1/news?apikey=';
  final String mediaStackUrl = 'http://api.mediastack.com/v1/news?access_key=';
  final String gNewsUrl = 'https://gnews.io/api/v4/search?q=domestic%20violence%20India&token=';
  
  Future<List<dynamic>> fetchArticles() async {
    try {
      final responses = await Future.wait([
        http.get(Uri.parse(newsApiUrl + newsApiKey)),
        http.get(Uri.parse(newsDataUrl + newsDataApiKey + '&q=domestic%20abuse%20India%20OR%20domestic%20violence%20India&country=in&language=en')),
        http.get(Uri.parse(mediaStackUrl + mediaStackApiKey + '&keywords=domestic%20abuse%20India,domestic%20violence%20India&countries=in&languages=en')),
        http.get(Uri.parse(gNewsUrl + gNewsApiKey + '&q=domestic%20abuse%20India&lang=en&country=in'))
      ]);

      List<dynamic> articles = [];

      for (var response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          if (data.containsKey('articles')) {
            articles.addAll(data['articles']); // NewsAPI & GNews
          } else if (data.containsKey('data')) {
            articles.addAll(data['data']); // NewsData.io & Mediastack
          }
        }
      }

      return articles;
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  // Declare API Keys
  final String newsApiKey = 'ec3843ff73e347aa95fbab40c1a4250e';
  final String newsDataApiKey = 'pub_73636a389d8c786867ea39ffb4434d49c8946';
  final String mediaStackApiKey = 'c4766a61650b9a8a896e28221fd11e19';
  final String gNewsApiKey = '9808b7534d3e4fcd9ff8a2a629de37b9';
  
  // Declare API URLs
  final String newsApiUrl = 'https://newsapi.org/v2/everything?q=domestic%20violence&language=en&sources=the-times-of-india,the-hindu,deccan-herald,ndtv,india-today,hindustan-times,financial-express&apiKey=';
  final String newsDataUrl = 'https://newsdata.io/api/1/news?apikey=';
  final String mediaStackUrl = 'http://api.mediastack.com/v1/news?access_key=';
  final String gNewsUrl = 'https://gnews.io/api/v4/search?q=domestic%20violence%20India&token=';

  Future<List<Map<String, dynamic>>> fetchArticles() async {
    try {
      final responses = await Future.wait([
        http.get(Uri.parse(newsApiUrl + newsApiKey)),
        http.get(Uri.parse(newsDataUrl + newsDataApiKey + '&q=domestic%20abuse%20India%20OR%20domestic%20violence%20India&country=in&language=en')),
        http.get(Uri.parse(mediaStackUrl + mediaStackApiKey + '&keywords=domestic%20abuse%20India,domestic%20violence%20India&countries=in&languages=en')),
        http.get(Uri.parse(gNewsUrl + gNewsApiKey + '&q=domestic%20abuse%20India&lang=en&country=in'))
      ]);

      List<Map<String, dynamic>> articles = [];

      for (var response in responses) {
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          List<dynamic> fetchedArticles = [];
          if (data.containsKey('articles')) {
            fetchedArticles = data['articles']; // NewsAPI & GNews
          } else if (data.containsKey('data')) {
            fetchedArticles = data['data']; // NewsData.io & Mediastack
          }

          for (var article in fetchedArticles) {
            articles.add({
              'title': article['title'],  // Keep only title
              // - not working - 'source': article['source'] is Map ? article['source']['name'] ?? 'Unknown' : article['source'] ?? 'Unknown',
              //'source': article['source']['name'] ?? 'Unknown',  // Include source name for clarity 
              // above line is working if the libtest is not changed and the with image code 
              'source': (article['source'] is Map) 
    ? (article['source']['name'] ?? 'Unknown') 
    : (article['source'] ?? 'Unknown'),
              'url': article['url'],  // Keep the URL in case user wants to read full article
            });
          }
        }
      }

      return articles;
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }
}
