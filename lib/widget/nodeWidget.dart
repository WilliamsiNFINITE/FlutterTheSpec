import 'dart:html';

import 'package:flutter/material.dart';
import '../automate.dart';

class NodeWidget extends StatefulWidget {
  const NodeWidget({super.key, required this.offset, required this.node, required this.onDragStarted});

  final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  @override
  State<StatefulWidget> createState() => NodeWidgetState();

}

class NodeWidgetState extends State<NodeWidget> {

  bool isDragged = false;
  bool isSelected = false;
  bool isDrawing = false;
  late Offset previousOffset;
  late Node node;
  late Offset offset;
  late Function onDragStarted;
  late double size;

  @override
  void initState() {
    this.offset = widget.offset;
    this.node = widget.node;
    this.size = widget.size;
    this.onDragStarted = widget.onDragStarted;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left:offset.dx - size / 2,
      top: offset.dy - size / 2,
      child: GestureDetector(
          onDoubleTap: () {
            setState(() {

            });
            // Offset position = Offset(offset.dx, offset.dy);
            // Offset cursorPosition = Offset(position.dx, position.dy);
            // print(position);
            // print(cursorPosition);
          },

          // On tap, makes a new line between the node and the cursor
          onTap: () => {
            setState(() {
              if (!isDrawing){
                // set a node as a source
                previousOffset = this.offset;
                // Draw line from node to mouse cursor

              }
              else{
                // draw the line between the previous set node and the actual node

              }
            }),
          },

          onPanStart: (data) => {
            setState(() {
              isDragged = true;
            }),
          },

          onPanUpdate: (data) => {
            setState(() {
              isDragged = true;
              offset = Offset(data.globalPosition.dx-(MediaQuery.of(context).size.width*0.1), data.globalPosition.dy-100);//offset from the menu
              onDragStarted(data.globalPosition.dx-(MediaQuery.of(context).size.width*0.1), data.globalPosition.dy-100);//offset from the menu
            }),
          },

         onPanEnd: (data) => {
            setState(() {
              isDragged = false;
            }),
          },

          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(1),
              // border: Border.all(color: Colors.black),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: TextField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Name:'),

                  controller: TextEditingController()..text = node.name,
                  onSubmitted: (value) => node.name = value,
                )),
          )),
    );
  }

}
