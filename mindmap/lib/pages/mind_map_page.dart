import 'package:flutter/material.dart';
import '../models/node.dart';
import '../widgets/mind_map_node.dart';

class MindMapPage extends StatefulWidget {
  @override
  _MindMapPageState createState() => _MindMapPageState();
}

class _MindMapPageState extends State<MindMapPage> {
  Node rootNode = Node(id: '1', title: 'Main Idea', children: [
    Node(id: '2', title: 'Sub Idea 1'),
    Node(id: '3', title: 'Sub Idea 2'),
  ]);

  void _addNode() {
    setState(() {
      rootNode.children.add(Node(id: '4', title: 'New Node'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Mapping Tool'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: _addNode),
        ],
      ),
      body: Center(
        child: MindMapNode(node: rootNode),
      ),
    );
  }
}