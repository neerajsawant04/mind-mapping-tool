import 'package:flutter/material.dart';

class MindMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Map'),
      ),
      body: MindMapWidget(),
    );
  }
}

class MindMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example root node for your mind map
    final rootNode = Node(
      title: 'Root Node', // Make sure 'title' is a required parameter in Node class
      id: '1', // Make sure 'id' is defined in the Node class
      label: 'This is the root node', // Make sure 'label' is defined in the Node class
      children: [], // Pass the children if applicable
    );

    return NodeWidget(node: rootNode); // Ensure NodeWidget accepts the 'node' parameter
  }
}

class Node {
  final String title;
  final String id;
  final String label;
  List<Node> children;

  Node({
    required this.title,
    required this.id,
    required this.label,
    this.children = const [],
  });
}

class NodeWidget extends StatelessWidget {
  final Node node;

  NodeWidget({required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(node.title),
          subtitle: Text(node.label),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete
            },
          ),
        ),
        for (var child in node.children) // Iterate through children if they exist
          NodeWidget(node: child), // Ensure NodeWidget can handle child nodes
      ],
    );
  }
}