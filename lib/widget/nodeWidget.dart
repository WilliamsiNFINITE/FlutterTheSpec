import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/relationPainter.dart';
import '../automate.dart';

class NodeWidget extends StatefulWidget {
  final ValueNotifier<bool> drawLineNotifier;
  final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  NodeWidget({super.key, required this.offset, required this.node, required this.onDragStarted, required this.drawLineNotifier});



  @override
  State<StatefulWidget> createState() => NodeWidgetState();

}

class NodeWidgetState extends State<NodeWidget> {

  late ValueNotifier<bool> drawLineNotifier;
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
    this.drawLineNotifier = widget.drawLineNotifier;
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
            print('double tap nodewidget');
            setState(() {

            });
            // Offset position = Offset(offset.dx, offset.dy);
            // Offset cursorPosition = Offset(position.dx, position.dy);
            // print(position);
            // print(cursorPosition);
          },

          // On tap, makes a new line between the node and the cursor
          onTap: () => {
            print('tap node widget $drawLineNotifier'),
            drawLineNotifier.value = !drawLineNotifier.value,
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

          child:
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
              ),
            ),
          )
          //
          // Container(
          //     alignment : Alignment.bottomCenter,
          //     child: TextField(
          //       decoration: const InputDecoration(
          //         // hoverColor: Colors.redAccent,
          //         // focusColor: Colors.redAccent,
          //           border: InputBorder.none,
          //           labelText: 'Name: '
          //       ),
          //       controller: TextEditingController()..text = node.name,
          //       onSubmitted: (value) => node.name = value,
          //     )
          // )
      );
  }

  void drawLine(Node initialNode) {
    //Draw a line from the node (previousOffset) to the cursor (pointer)
    Offset pointerOffset = Offset(400, 400);
    print("draw line");

    CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: PartialRelationPainter(initialNode: initialNode),
    );
    isDrawing = true;

  }

}
