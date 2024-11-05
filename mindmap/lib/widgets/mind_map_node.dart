import 'package:flutter/material.dart';
import '../models/node.dart';

class MindMapNode extends StatefulWidget {
  final Node node;
  final Function(Node) onDelete; // Callback to delete a node

  MindMapNode({required this.node, required this.onDelete});

  @override
  _MindMapNodeState createState() => _MindMapNodeState();
}

class _MindMapNodeState extends State<MindMapNode> {
  bool isExpanded = true; // Track if the node is expanded
  final TextEditingController _titleController = TextEditingController();
  late Node newNode; // Temporary node for new children

  @override
  void initState() {
    super.initState();
    newNode = Node(title: ''); // Initialize a new node with an empty title
    _titleController.text = widget.node.title; // Set the title from the current node
  }

  // Function to add a child node
  void _addChild() {
    if (newNode.title.isNotEmpty) {
      setState(() {
        widget.node.children.add(newNode); // Add the new node to the children
        newNode = Node(title: ''); // Reset newNode for another input
      });
    }
  }

  // Function to delete the current node
  void _deleteNode() {
    widget.onDelete(widget.node);
  }

  // Function to toggle expansion
  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _toggleExpansion,
                    child: Text(
                      _titleController.text,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: _deleteNode,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Edit title'),
              onSubmitted: (value) {
                setState(() {
                  widget.node.title = value; // Update the node title
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Add child node title'),
                    onChanged: (value) {
                      newNode.title = value; // Update newNode title
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addChild,
                ),
              ],
            ),
          ),
          if (widget.node.children.isNotEmpty) ...[
            for (var child in widget.node.children)
              MindMapNode(
                node: child,
                onDelete: (Node nodeToDelete) {
                  setState(() {
                    widget.node.children.remove(nodeToDelete);
                  });
                },
              ),
          ],
        ],
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose(); // Clean up the controller
    super.dispose();
  }
}