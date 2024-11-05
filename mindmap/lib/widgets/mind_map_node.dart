import 'package:flutter/material.dart';
import '../models/node.dart';

class MindMapNode extends StatelessWidget {
  final Node node;
  final Function(Node) editNode;
  final Function(Node, Node) deleteNode;

  MindMapNode({required this.node, required this.editNode, required this.deleteNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            editNode(node);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlue[100],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Text(node.label)),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Call the delete function
                    deleteNode(node.parent!, node);
                  },
                ),
              ],
            ),
          ),
        ),
        if (node.children.isNotEmpty)
          Column(
            children: node.children
                .map((childNode) => MindMapNode(
                      node: childNode,
                      editNode: editNode,
                      deleteNode: deleteNode,
                    ))
                .toList(),
          ),
      ],
    );
  }
}