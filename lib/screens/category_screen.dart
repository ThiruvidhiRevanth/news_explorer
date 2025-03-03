

import 'package:flutter/material.dart';
import 'package:news_explorer/screens/home_screen.dart';
import 'package:news_explorer/Theme/theme_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: CategoryScreen(),
    ),
  );
}

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: themeProvider.themeData,
      debugShowCheckedModeBanner: false,
      home: MyCategoryScreen(),
    );
  }
}

class MyCategoryScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"title": "General", "image": "assests/images/general.jpeg"},
    {"title": "Technology", "image": "assests/images/tech.jpeg"},
    {"title": "Business", "image": "assests/images/economy.jpeg"},
    {"title": "Sports", "image": "assests/images/sport.jpeg"},
    {"title": "Health", "image": "assests/images/health.jpeg"},
    {"title": "Entertainment", "image": "assests/images/fun.jpeg"},
    {"title": "Science", "image": "assests/images/science.jpeg"},
    {"title": "Music", "image": "assests/images/music.jpeg"},
    {"title": "Arts", "image": "assests/images/arts.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Category")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomeScreen(category: categories[index]["title"]!),
                  ),
                );
              },
              child: CategoryCard(
                title: categories[index]["title"]!,
                imagePath: categories[index]["image"]!,
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
