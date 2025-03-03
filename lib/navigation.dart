import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/video_news_screen.dart';
import 'Theme/theme_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Navigation(),
    ),
  );
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
          var themeProvider = Provider.of<ThemeProvider>(context);
    return  MaterialApp(
        theme:themeProvider.themeData,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  int _selectedScreenIndex = 0;
  final List _screens =  [
    {"screen": HomeScreen(), "title": "Screen A Title"},
    {"screen": VideoNewsScreen(), "title": "Screen A Title"},
   {"screen": CategoryScreen(), "title": "Screen B Title"},
    {"screen":ProfileScreen(), "title": "Screen C Title"},
    

  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_selectedScreenIndex]["screen"],
    
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
      // Opposite color
        onTap: _selectScreen,
         items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      

          // BottomNavigationBarItem(icon: ImageIcon(AssetImage("assests/images/browser.png"))   ,label: ""),

        ],)
      
    );
  }
}