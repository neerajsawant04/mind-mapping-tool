class Node {
  String title;
  int? parentId; // Use this to establish parent-child relationships

  Node({required this.title, this.parentId});
}