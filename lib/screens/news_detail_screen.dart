import 'package:flutter/material.dart';
import '../models/article_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;
  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" ")),
      body: Column(
        children: [
          article.urlToImage.isNotEmpty
              ? Image.network(article.urlToImage, fit: BoxFit.cover)
              : Container(height: 200, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(article.title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          ),
          Row(
            children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(article.author, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          ),
           Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 100, 0),
            child: Text(article.publishedAt, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          ),],),
          
          Divider(
            indent: 15,
            endIndent: 15,
             
             thickness: .7,
          ),
         
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,0,8,0),
            child: Text(article.content, style: TextStyle(fontSize: 16)),
          ),
          
        ],
      ),
    );
  }
}
