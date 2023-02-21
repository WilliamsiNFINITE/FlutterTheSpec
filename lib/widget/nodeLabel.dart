import 'package:flutter/material.dart';
import '../automaton.dart';

class NodeLabel extends StatefulWidget {
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final Node node;
  final double size = 100;

  NodeLabel({super.key, required this.notifierMap, required this.node});

  @override
  State<StatefulWidget> createState() => NodeLabelState();
}

class NodeLabelState extends State<NodeLabel> {

  bool isDragged = false;
  late Automaton automate;
  late Map<String, ValueNotifier<dynamic>> notifierMap;
  late Node node;
  late Offset offset;
  late String label;
  double size = 100;

  @override
  void initState() {
    this.notifierMap = widget.notifierMap;
    this.node = notifierMap['automata']?.value.nodes.last;
    this.automate = notifierMap['automata']?.value;
    this.label = this.node.name;
    this.offset = this.node.offset;

    notifierMap['automata']?.addListener(() {
      setState(() {
        automate = notifierMap['automata']?.value;
        for (var nodeIter in automate.nodes) {
          if (nodeIter.offset == node.offset) {
            offset = nodeIter.offset;
            label = nodeIter.name;
          }
        }
      });
    });
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
          Text(label),

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
