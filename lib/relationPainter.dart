import 'package:flutter/material.dart';
import 'automate.dart';


class RelationPainter extends CustomPainter {
  RelationPainter({required this.nodeMap, required this.relations});

  final Map<Node, Offset> nodeMap;
  final List<Relation> relations;

  @override
  void paint(Canvas canvas, Size size) {
    //check if relations is empty
    if (relations.isEmpty) {
      return;
    }
    for (Relation relation in relations) {
      //find the offsets and draw the line
      // print('relation: ${relation.source} -> ${relation.target}');
      for (Node node in nodeMap.keys) {
        if (node.name == relation.source) {
          Offset start = nodeMap[node]!;
          //find the ending offset
          for (Node node in nodeMap.keys) {
            if (node.name == relation.target) {
              Offset end = nodeMap[node]!;
              //draw the line
              canvas.drawLine(
                  start,
                  end,
                  Paint()
                    ..color = Colors.black
                    ..strokeWidth = 2);
            }
          }
        }
      }
    }


  }

  @override
  bool shouldRepaint(RelationPainter oldDelegate) => true;
}


class PartialRelationPainter extends CustomPainter {
  PartialRelationPainter({required this.initialNode});

  final Node initialNode;
  late Offset end;

  @override
  void paint(Canvas canvas, Size size) {

    Offset start = initialNode.offset;
    Offset end = Offset(50, 50);
    //find the ending offset
        canvas.drawLine(
            start,
            end,
            Paint()
              ..color = Colors.black
              ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(RelationPainter oldDelegate) => true;
}
