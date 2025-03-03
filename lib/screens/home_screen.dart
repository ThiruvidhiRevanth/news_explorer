import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news_bloc.dart';
import '../blocs/news_state.dart';
import 'news_detail_screen.dart';
import 'package:news_explorer/api_service.dart';
import 'package:news_explorer/blocs/news_event.dart';
import 'package:news_explorer/Theme/theme_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: HomeScreen(),
    ),
  );
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home:  MyHomeScreen(category: "General"),
      
    );
  }
}
class MyHomeScreen extends StatefulWidget {
  final String category;

  const MyHomeScreen({Key? key, required this.category}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 10;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      key: ValueKey(widget.category),
      create: (context) => NewsBloc(ApiService())..add(FetchNews(category: widget.category)),
        child:Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              article.urlToImage.isNotEmpty
                                  ? Image.network(
                                      article.urlToImage,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                       errorBuilder: (context, error, stackTrace) {
    return Container(width: 100, height: 100, color: Colors.grey);
  },
                                    )
                                  : Container(width: double.infinity, height: 200, color: Colors.grey),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.7),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                right: 10,
                                child: Text(
                                  article.title, // ✅ Fixed property name
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.black45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return ListTile(
  contentPadding: const EdgeInsets.all(10),

  // Ensures leading section has enough space
  leading: SizedBox(
    width: 100, // Increased width
    height: 150, // Increased height
    child: article.urlToImage.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              article.urlToImage,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(width: 150, height: 150, color: Colors.grey);
              },
            ),
          )
        : Container(width: 150, height: 150, color: Colors.grey),
  ),
  title: Text(
    article.title,
    style: const TextStyle(fontWeight: FontWeight.bold),
  ),
  subtitle: Text(article.publishedAt ?? ""),
  onTap: () => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => NewsDetailScreen(article: article),
    ),
  ),
);

                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Failed to fetch news"));
          }
        },
      ),
    ));
  }
}