import 'package:flutter/material.dart';
import '../models/node.dart';
import '../widgets/mind_map_node.dart';


class MindMapPage extends StatefulWidget {
  @override
  _MindMapPageState createState() => _MindMapPageState();
}

class _MindMapPageState extends State<MindMapPage> {
  late Node rootNode;

  @override
  void initState() {
    super.initState();
    // Initialize the root node with some children
    rootNode = Node(
      title: 'Mind Map',
      children: [
        Node(title: 'Child Node 1'),
        Node(title: 'Child Node 2', children: [
          Node(title: 'Grandchild Node 1'),
          Node(title: 'Grandchild Node 2'),
        ]),
      ],
    );
  }

  void _addChildNode(Node parentNode) {
    setState(() {
      parentNode.children.add(Node(title: 'New Child Node'));
    });
  }

  void _deleteNode(Node nodeToDelete) {
    _removeNode(rootNode, nodeToDelete);
  }

  bool _removeNode(Node parentNode, Node nodeToDelete) {
    if (parentNode.children.remove(nodeToDelete)) {
      return true;
    }
    for (var child in parentNode.children) {
      if (_removeNode(child, nodeToDelete)) {
        return true;
      }
    }
    return false;
  }

  void _showAddNodeDialog(Node parentNode) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Child Node'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Node Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    parentNode.children.add(Node(title: controller.text));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
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
        title: Text('Mind Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  MindMapNode(
                    node: rootNode,
                    onDelete: _deleteNode,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _showAddNodeDialog(rootNode),
              child: Text('Add Child Node to Root'),
            ),
          ],
        ),
      ),
    );
  }
}