import 'dart:math';

import 'package:flutter/material.dart';
import 'node.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget(
      {super.key,
        required this.offset,
        required this.node,
        required this.onDragStarted});
  final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx - size / 2,
      top: offset.dy - size / 2,
      child: GestureDetector(
          onPanStart: (data) =>
              onDragStarted(data.globalPosition.dx, data.globalPosition.dy),
          onPanUpdate: (data) =>
              onDragStarted(data.globalPosition.dx, data.globalPosition.dy),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.7),
              border: Border.all(color: Colors.black),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name:'),
                  controller: TextEditingController()..text = node.name,
                  onSubmitted: (value) => node.name = value,
                )),
          )),
    );
  }
}
