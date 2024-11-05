import 'package:flutter/material.dart';

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
      ),
      home: LoginPage(),
    );
  }
}

// Login Page
class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to MindMapPage after login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MindMapPage()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Mind Map Page
class MindMapPage extends StatefulWidget {
  @override
  _MindMapPageState createState() => _MindMapPageState();
}

class _MindMapPageState extends State<MindMapPage> {
  final List<MindMapNode> _nodes = [];
  final TextEditingController _nodeTitleController = TextEditingController();

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _nodes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_nodes[index].title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editNode(context, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _nodeTitleController,
              decoration: InputDecoration(
                hintText: 'Node Title',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addNode();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNode() {
    if (_nodeTitleController.text.isNotEmpty) {
      setState(() {
        _nodes.add(MindMapNode(title: _nodeTitleController.text));
        _nodeTitleController.clear();
      });
    }
  }

  void _editNode(BuildContext context, int index) {
    _nodeTitleController.text = _nodes[index].title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Node'),
          content: TextField(
            controller: _nodeTitleController,
            decoration: InputDecoration(hintText: 'Node Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_nodeTitleController.text.isNotEmpty) {
                  setState(() {
                    _nodes[index].title = _nodeTitleController.text;
                  });
                  _nodeTitleController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

// MindMapNode Model
// MindMapNode Model
class MindMapNode {
  String id;  // Unique identifier for the node
  String title;  // Title of the node
  String? description;  // Optional description of the node
  Color color;  // Color of the node for visual distinction
  List<MindMapNode> children;  // List to hold child nodes

  MindMapNode({
    required this.id,
    required this.title,
    this.description,
    this.color = Colors.blue,  // Default color
  }) : children = [];  // Initialize children as an empty list

  // Method to add a child node
  void addChild(MindMapNode child) {
    children.add(child);
  }

  // Method to remove a child node by ID
  void removeChild(String childId) {
    children.removeWhere((child) => child.id == childId);
  }
}