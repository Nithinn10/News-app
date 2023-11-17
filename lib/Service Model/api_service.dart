import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_model.dart';

class NewsService {

  static const apiKey = "775f445f80f44895ae2a208a9c636c8d"; 
  static const apiUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('$apiUrl?country=us&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.map((article) => News.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
