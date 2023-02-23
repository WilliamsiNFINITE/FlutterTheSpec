import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/relationPainter.dart';
import 'package:widget_arrows/widget_arrows.dart';
import '../../automaton.dart';
import 'nodeProperty.dart';

class NodeWidget extends StatefulWidget {
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  // final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  NodeWidget(
      {super.key,
      required this.node,
      required this.onDragStarted,
      required this.notifierMap});

  @override
  State<StatefulWidget> createState() => NodeWidgetState();
}

class NodeWidgetState extends State<NodeWidget> {
  late Map<String, ValueNotifier<dynamic>> notifierMap;
  bool isDragged = false;
  bool isDrawing = false;
  late Node node;
  late Function onDragStarted;
  late double size;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    notifierMap = widget.notifierMap;
    node = widget.node;
    size = widget.size;
    onDragStarted = widget.onDragStarted;

    notifierMap['automata']?.addListener(() {
      setState(() {
        for (var nodeIter in notifierMap['automata']?.value.nodes) {
          if (nodeIter.name == node.name) {
            node = nodeIter;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // notifierMap["selectedWidget"]?.value[node.name] = isSelected;
    return Positioned(
      left: node.offset.dx - size / 2,
      top: node.offset.dy - size / 2,
      child: GestureDetector(
          onDoubleTap: () {
            // open a dialog window to edit the node properties
            openNodeDialog();
          },

          // On tap, makes a new line between the node and the cursor
          onTap: () => {
                setState(() {
                  if (notifierMap['addRelationButton']?.value) {
                    // if the add relation button is pressed
                    notifierMap['drawLineNotifier']?.value =
                        !notifierMap['drawLineNotifier']?.value;
                    if (notifierMap['drawLineNotifier']?.value) {
                      notifierMap['beginNode']?.value = node;
                    } else {
                      // if the line is finished
                      notifierMap['endNode']?.value = node;
                      // now that we have the begin and end node, we can add a new relation
                      addNewRelation();
                    }
                  }
                  if (notifierMap['selectButton']?.value) {
                    node.isSelected = !node.isSelected;
                    notifierMap['automata']?.notifyListeners();
                  }
                }),
                // print('taped node widget : ${notifierMap['selectedWidget']!.value}}'),
                // print('taped node widget : ${notifierMap['automata']!.value}}'),

                // print('tap node widget $drawLineNotifier'),
              },
          onTapDown: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            _tapPosition = box.globalToLocal(details.globalPosition);
          },
          onPanStart: (data) => {
                setState(() {
                  isDragged = true;
                }),
              },
          onPanUpdate: (data) => {
                setState(() {
                  isDragged = true;
                  node.offset = Offset(
                      data.globalPosition.dx -
                          (MediaQuery.of(context).size.width * 0.1),
                      data.globalPosition.dy - 100); //offset from the menu
                  onDragStarted(
                      data.globalPosition.dx -
                          (MediaQuery.of(context).size.width * 0.1),
                      data.globalPosition.dy - 100); //offset from the menu
                }),
                notifierMap['automata']?.notifyListeners(),
              },
          onPanEnd: (data) => {
                setState(() {
                  isDragged = false;
                }),
              },
          child: Stack(children: [
            Container(
              width: size,
              height: size,
              decoration:
              BoxDecoration(
                color: node.isInitial&&node.isSelected? Colors.grey : node.isInitial ? Colors.grey.shade700 : node.isSelected ? Colors.blueAccent.shade100 : Colors.blueAccent, //node.isInitial&&isSelected? Colors.grey : node.isInitial ? Colors.grey.shade700 : node.isFinal&&isSelected? Colors.orange : node.isFinal ? Colors.deepOrange  : isSelected ? Colors.blueAccent.shade100 : Colors.blueAccent,
                shape: node.isUrgent? BoxShape.rectangle : BoxShape.circle,
                border: Border.all(color: Colors.black, width: node.isUrgent? 5 : 2),
              ),
            ),
            // ...List<Widget> _buildArrows(),
          ])),
    );
  }

  Future openNodeDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return NodeProperty(node: node, notifierMap: notifierMap);
        });
  }


  void addNewRelation() {
    // add a new relation between the begin and end node
    if (notifierMap['beginNode']?.value != null &&
        notifierMap['endNode']?.value != null) {
      Relation relation = Relation(
          source: notifierMap['beginNode']?.value,
          target: notifierMap['endNode']?.value);

      Automaton automata = notifierMap['automata']?.value;
      automata.relations.add(relation);
      notifierMap['automata']?.value = automata;
      print('new relation added');
    } else {
      print('begin or end node is null');
    }
    notifierMap['automata']?.notifyListeners();
  }
}
//