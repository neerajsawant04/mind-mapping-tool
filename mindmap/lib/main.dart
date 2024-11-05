import 'package:flutter/material.dart';
import 'models/node.dart';
import 'pages/mind_map_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Mapping Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.black),
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      ),
      home: MindMapPage(),
    );
  }
}