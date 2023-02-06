import 'package:flutter/material.dart';
import '../automate.dart';

class NodeLabel extends StatefulWidget {
  final Node node;
  final double size = 100;

  NodeLabel({super.key, required this.node});

  @override
  State<StatefulWidget> createState() => NodeLabelState();

}

class NodeLabelState extends State<NodeLabel> {

  bool isDragged = false;
  late Node node;
  late Offset offset;
  double size = 100;

  @override
  void initState() {
    this.node = widget.node;
    this.offset = node.offset;

  }

  @override
  Widget build(BuildContext context) {
    // put a listener on the node to update the offset when the node is moved

    return Positioned(
      left: offset.dx,
      top:  offset.dy + size / 2,
      child: GestureDetector(
          onPanStart: (data) => {
            setState(() {
              isDragged = true;
            }),
          },
          onPanUpdate: (data) => {
            setState(() {
              isDragged = true;
               offset = Offset(data.globalPosition.dx-(MediaQuery.of(context).size.width*0.1), data.globalPosition.dy-100 - size/2);//offset from the menu
            }),
          },
          onPanEnd: (data) => {
            setState(() {
              isDragged = false;
            }),
          },
          child:
          Text(node.name),

          // TextField(
          //   decoration: const InputDecoration(
          //       border: InputBorder.none,
          //       labelText: 'Name: '
          //   ),
          //   controller: TextEditingController()..text = node.name,
          //   onSubmitted: (value) => node.name = value,
          // )
          //
          // const TextField(
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: 'Password',
          //   ),
          // )


      )
    );
  }
}
