import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/node/nodeLabel.dart';
import '../../automaton.dart';
import '../node/nodeWidget.dart';
import '../relationWidget.dart';
import 'graphScene.dart';
import '../relationPainter.dart';
// import to read data from internet
import 'package:http/http.dart' as http;

class GraphSceneState extends State<GraphScene> {
  late Map<String, ValueNotifier<dynamic>> notifierMap = widget.notifierMap;
  late Automaton automate;

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
        Uri.parse('https://dl.dropbox.com/s/e2886piklyftecv/nodes.json?dl=0'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get the data');
    }
  }

  importAutomateFromWeb() async {
    Map<String, dynamic> data = await fetchData();

    var automateTemp = Automaton.fromJson(data);

    setState(() {
      automate = automateTemp;
    });
  }

  // partie de production
  final TransformationController _transformationController =
      TransformationController();
  int idx = 0;

  Function onDragStarted(Node key) => (x, y) {
        setState(() {
          key.offset = _transformationController.toScene(Offset(x, y));
        });
      };

  @override
  void initState() {
    super.initState();
    automate = notifierMap['automata']?.value;

    notifierMap['automata']?.addListener(() {
      setState(() {
        automate = notifierMap['automata']?.value;
        print('automata changed in graphSceneState');
      });
    });
  }

  Offset? _doubleTapPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (notifierMap['addNodeButton']?.value)
          {
            // if the button for placing a new node is pressed
            setState(() {
              addNewNode('new node ${idx}',
                  _transformationController.toScene(_doubleTapPosition!));
              idx++;
            }),
          },
        print('tap graphSceneState'),
      },
      onTapDown: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        _doubleTapPosition = box.globalToLocal(details.globalPosition);
      },
      child: Center(
          child: InteractiveViewer(
        transformationController: _transformationController,
        child: Stack(children: <Widget>[
          // be sure to add the custom painter first so it is at the bottom of the stack.
          CustomPaint(
            size: const Size(double.infinity, double.infinity),
            painter: RelationPainter(automaton: automate),
          ),
          ..._buildNodes(),
          ..._buildLabels(),
        ]),
      )),
    );
  }

  List<Widget> _buildNodes() {
    final res = <Widget>[];

    automate.nodes.forEach((nodeToBuild) {
      res.add(NodeWidget(
          node: nodeToBuild,
          onDragStarted: onDragStarted(nodeToBuild),
          notifierMap: notifierMap));
    });
    //
    // for (Node node in automate.nodes){
    //   res.add(NodeWidget(node: node, onDragStarted: onDragStarted(node), notifierMap: notifierMap));
    // }

    notifierMap['automata']?.notifyListeners();
    return res;
  }

  List<Widget> _buildLabels() {
    final res = <Widget>[];
    automate.nodes.forEach((node) {
      res.add(NodeLabel(notifierMap: notifierMap, node: node));
    });
    return res;
  }

  void addNewNode(String name, Offset offset) {
    automate.nodes.add(Node(name: name, offset: offset));
    notifierMap['automata']!.notifyListeners();
  }
}
