import 'package:flutter/material.dart';

class MindMapNode {
  String id; // Unique identifier for the node
  String title; // Title of the node
  String? description; // Optional description of the node
  Colors color; // Color of the node for visual distinction
  List<MindMapNode> children; // List to hold child nodes

  MindMapNode({
    required this.id,
    required this.title,
    this.description,
    this.color = Colors.blue, // Default color
  }) : children = []; // Initialize children as an empty list

  // Method to add a child node
  void addChild(MindMapNode child) {
    children.add(child);
  }

  // Method to remove a child node by ID
  void removeChild(String childId) {
    children.removeWhere((child) => child.id == childId);
  }
}