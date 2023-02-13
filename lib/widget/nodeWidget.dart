import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/relationPainter.dart';
import 'package:widget_arrows/widget_arrows.dart';
import '../automaton.dart';

class NodeWidget extends StatefulWidget {
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  NodeWidget(
      {super.key,
      required this.offset,
      required this.node,
      required this.onDragStarted,
      required this.notifierMap});

  @override
  State<StatefulWidget> createState() => NodeWidgetState();
}

class NodeWidgetState extends State<NodeWidget> {
  late Map<String, ValueNotifier<dynamic>> notifierMap;
  bool isDragged = false;
  bool isSelected = false;
  bool isDrawing = false;
  late Offset previousOffset;
  late Node node;
  late Offset offset;
  late Function onDragStarted;
  late double size;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    this.notifierMap = widget.notifierMap;
    this.offset = widget.offset;
    this.node = widget.node;
    this.size = widget.size;
    this.onDragStarted = widget.onDragStarted;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offset.dx - size / 2,
        top: offset.dy - size / 2,
        child: GestureDetector(
          onDoubleTap: () {
            print('double tap nodewidget');
            setState(() {});
          },

          // On tap, makes a new line between the node and the cursor
          onTap: () =>
          {
            setState(() {
              if (notifierMap['addRelationButton']?.value){
                notifierMap['drawLineNotifier']?.value =
                !notifierMap['drawLineNotifier']?.value;
                if (notifierMap['drawLineNotifier']?.value) {
                  notifierMap['beginNode']?.value = node;
                  print('begin node ${notifierMap['beginNode']?.value.name}');
                } else {
                  notifierMap['endNode']?.value = node;
                  print('end node ${notifierMap['endNode']?.value.name}');
                  // now that we have the begin and end node, we can add a new relation
                  addNewRelation();
                }
              }
            }),
            print('taped node widget'),

            // print('tap node widget $drawLineNotifier'),
          },

          onTapDown: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            _tapPosition = box.globalToLocal(details.globalPosition);
          },


          onPanStart: (data) =>
          {
            setState(() {
              isDragged = true;
            }),
          },

          onPanUpdate: (data) =>
          {
            setState(() {
              isDragged = true;
              offset = Offset(
                  data.globalPosition.dx -
                      (MediaQuery
                          .of(context)
                          .size
                          .width * 0.1),
                  data.globalPosition.dy - 100); //offset from the menu
              onDragStarted(
                  data.globalPosition.dx -
                      (MediaQuery
                          .of(context)
                          .size
                          .width * 0.1),
                  data.globalPosition.dy - 100); //offset from the menu
            }),
          },

          onPanEnd: (data) =>
          {
            setState(() {
              isDragged = false;
            }),
          },

          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
            ),
          ),

          // child: ArrowElement(
          //       show: false,
          //       id: "text",
          //       targetAnchor: Alignment.centerRight,
          //       child: Container(
          //         width: size,
          //         height: size,
          //         decoration: BoxDecoration(
          //           color: Colors.blueAccent,
          //           border: Border.all(color: Colors.black),
          //           shape: BoxShape.circle,
          //         ),
          //       ),
          //     ),
        )

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

  void addNewRelation() {
    // add a new relation between the begin and end node
    if (notifierMap['beginNode']?.value != null &&
        notifierMap['endNode']?.value != null) {
      Relation relation = Relation(source: notifierMap['beginNode']?.value.name,
          target: notifierMap['endNode']?.value.name);
      // notifierMap['beginNode']?.value = null;
      // notifierMap['endNode']?.value = null;
      // now that the relation is created, we can add it to the automata
      Automaton automata = notifierMap['automata']?.value;
      automata.relations.add(relation);
      notifierMap['automata']?.value = automata;
      print('new relation added');
    }
    else {
      print('begin or end node is null');
    }

    print(notifierMap['beginNode']?.value.offset);
    print(notifierMap['endNode']?.value.offset);

  }
}