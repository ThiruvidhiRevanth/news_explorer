import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/article_model.dart';

class ApiService {
 
  Future<List<Article>> fetchNews({String category = "General"}) async {
  final response = await http.get(
    Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=aa65977c0d6846b4b45b06304730dcd4'),
    
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return (data['articles'] as List).map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception("Failed to load news");
  }
}

}
