import 'package:flutter/material.dart';
import 'automate.dart';


class RelationPainter extends CustomPainter {
  RelationPainter({required this.nodeMap});

  final Map<Node, Offset> nodeMap;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodeMap.length > 1) {
      Node? previous;
      nodeMap.forEach((index, offset) {
        if (previous == null) {
          previous = index;
          return;
        }
        canvas.drawLine(
          offset,
          nodeMap[previous]!,
          Paint()
            ..color = Colors.blue
            ..strokeWidth = 2,
        );
        previous = index;
      });
    }
  }

  @override
  bool shouldRepaint(RelationPainter oldDelegate) => true;
}
