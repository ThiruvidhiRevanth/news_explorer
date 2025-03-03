import 'package:flutter/material.dart';
import 'dart:async';
import 'Theme/theme_provider.dart';
import 'navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news_bloc.dart';
import 'package:news_explorer/api_service.dart';
import 'package:provider/provider.dart';
import '../blocs/news_event.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (_) => NewsBloc(ApiService())..add(FetchNews()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var themeProvider = Provider.of<ThemeProvider>(context);

    return  MaterialApp(
      themeMode: ThemeMode.system,
      theme:themeProvider.themeData,
      
      debugShowCheckedModeBanner: false,
      title: '',
      home:const MyHomePage(),
      
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Navigation(),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Stack(children: [
       
       
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assests/images/mohans.jpg",
                        scale: 1,
                      ),
                    ),
      ]),
    );
  }

}
