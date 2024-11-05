import 'package:flutter/material.dart';
import '../models/node.dart';

class MindMapNode extends StatelessWidget {
  final Node node;
  final Function(Node) onDelete;
  final Function(Node) onEdit;

  MindMapNode({required this.node, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => onEdit(node), // Edit on double-tap
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(node.title, style: TextStyle(fontSize: 18)),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => onDelete(node),
              ),
            ],
          ),
        ),
      ),
    );
  }
}