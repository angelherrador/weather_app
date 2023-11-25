import 'package:flutter/material.dart';
import 'package:whether_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            backgroundColor: Colors.indigo,
            //toolbarHeight: 25, alto de la AppBar
            centerTitle: true
        ),
      ),
      home: const Home(),
    );
  }
}
