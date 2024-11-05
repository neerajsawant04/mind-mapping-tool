import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/mind_map_node.dart';
import '../models/node.dart';

class MindMapPage extends StatefulWidget {
  @override
  _MindMapPageState createState() => _MindMapPageState();
}

class _MindMapPageState extends State<MindMapPage> {
  List<Node> nodes = [];
  final TextEditingController _nodeController = TextEditingController();

  void _addNode() {
    if (_nodeController.text.isNotEmpty) {
      setState(() {
        nodes.add(Node(title: _nodeController.text));
        _nodeController.clear();
      });
    }
  }

  void _deleteNode(Node node) {
    setState(() {
      nodes.remove(node);
    });
  }

  void _editNode(Node node) {
    _nodeController.text = node.title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Node'),
          content: TextField(
            controller: _nodeController,
            decoration: InputDecoration(labelText: 'Node Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  node.title = _nodeController.text;
                  _nodeController.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mind Mapping Tool'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNode,
          ),
        ],
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          // Implement panning functionality here
        },
        onScaleUpdate: (details) {
          // Implement zoom functionality here
        },
        child: CustomPaint(
          painter: MindMapPainter(nodes),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: nodes.map((node) {
                return MindMapNode(
                  node: node,
                  onDelete: _deleteNode,
                  onEdit: _editNode,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class MindMapPainter extends CustomPainter {
  final List<Node> nodes;

  MindMapPainter(this.nodes);

  @override
  void paint(Canvas canvas, Size size) {
    // Implement node connections here
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var node in nodes) {
      if (node.parentId != null) {
        // Draw connections based on parent-child relationships
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}