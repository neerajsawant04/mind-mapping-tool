class Node {
  String id;
  String title;
  List<Node> children;

  Node({required this.id, required this.title, this.children = const []});
}