import 'package:flutter/material.dart';
import 'package:learning_bloc/home_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Learning',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
