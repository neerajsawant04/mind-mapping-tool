import 'package:flutter/material.dart';
import 'models/node.dart';
import 'pages/mind_map_page.dart';
import 'widgets/mind_map_node.dart';
import 'widgets/node_connector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Map App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Simulated login logic
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MindMapPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter username and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MindMapPage extends StatefulWidget {
  @override
  _MindMapPageState createState() => _MindMapPageState();
}

class _MindMapPageState extends State<MindMapPage> {
  late Node rootNode;

  @override
  void initState() {
    super.initState();
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () => _showAddNodeDialog(rootNode),
                child: Text('Add Child Node to Root'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MindMapNode extends StatelessWidget {
  final Node node;
  final Function(Node) onDelete;

  MindMapNode({required this.node, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ExpansionTile(
          title: Text(
            node.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _showAddNodeDialog(context, node),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(node),
                ),
              ],
            ),
            ...node.children.map((child) {
              return MindMapNode(
                node: child,
                onDelete: onDelete,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showAddNodeDialog(BuildContext context, Node parentNode) {
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
                  Navigator.of(context).pop();
                  (context.findAncestorStateOfType<_MindMapPageState>()!)
                      ._addChildNode(parentNode);
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
}