import 'package:flutter/material.dart';
import '../automaton.dart';


class RelationPainter extends CustomPainter {
  RelationPainter({required this.automaton});

  final Automaton automaton;

  @override
  void paint(Canvas canvas, Size size) {
    //check if relations is empty
    if (automaton.relations.isEmpty) {
      return;
    }
    for (Relation relation in automaton.relations) {
      //find the offsets and draw the line
      // print('relation: ${relation.source} -> ${relation.target}');
      for (Node node in automaton.nodes) {
        if (node == relation.source) {
          Offset start = node.offset;
          //find the ending offset
          for (Node node in automaton.nodes) {
            if (node == relation.target) {
              Offset end = node.offset;
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
