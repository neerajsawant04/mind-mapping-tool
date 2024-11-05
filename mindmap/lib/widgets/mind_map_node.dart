import 'package:flutter/material.dart';
import '../models/node.dart';
import 'node_connector.dart';

class MindMapNode extends StatelessWidget {
  final Node node;

  MindMapNode({required this.node});

  @override
  Widget build(BuildContext context) {
    return Draggable<Node>(
      data: node,
      child: _buildNode(),
      feedback: _buildNode(),
      childWhenDragging: Container(),
    );
  }

  Widget _buildNode() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            node.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          ...node.children.map((child) => MindMapNode(node: child)).toList(),
        ],
      ),
    );
  }
}