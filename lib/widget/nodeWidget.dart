import 'package:flutter/material.dart';
import '../automate.dart';

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
          onDoubleTap: () {
            Offset position = Offset(offset.dx, offset.dy);
            Offset cursorPosition = Offset(position.dx, position.dy);
            print(position);
            print(cursorPosition);
          },
          onTap: () => {print(node.name)},
          onPanStart: (data) =>
              onDragStarted(data.globalPosition.dx-(MediaQuery.of(context).size.width*0.1), data.globalPosition.dy-100), //offset from the menu
          onPanUpdate: (data) =>
              onDragStarted(data.globalPosition.dx-(MediaQuery.of(context).size.width*0.1), data.globalPosition.dy-100), //offset from the menu

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
