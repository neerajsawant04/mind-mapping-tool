import 'package:flutter/material.dart';
import 'pages/mind_map_page.dart';

void main() {
  runApp(MindMappingApp());
}

class MindMappingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Mapping Tool',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MindMapPage(),
    );
  }
}