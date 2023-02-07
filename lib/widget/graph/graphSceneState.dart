import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/nodeLabel.dart';
import '../../automate.dart';
import '../nodeWidget.dart';
import 'graphScene.dart';
import '../relationPainter.dart';
// import to read data from internet
import 'package:http/http.dart' as http;

class GraphSceneState extends State<GraphScene> {
  late Map<String, ValueNotifier<dynamic>> notifierMap = widget.notifierMap;

  ValueNotifier<bool> drawLineNotifier = ValueNotifier(false);

  Map<Node, Offset> nodeMap = {};
  List<Node> nodes = [];
  List<Relation> relations = [];
  late Automate automate;

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

    var automateTemp = Automate.fromJson(data);
    var nodesTemp = automateTemp.nodes;
    var relationsTemp = automateTemp.relations;
    Map<Node, Offset> nodeMapTemp = {};

    for (Node node in nodesTemp) {
      nodeMapTemp[node] = Offset(node.offset.dx, node.offset.dy);
    }

    setState(() {
      automate = automateTemp;
      nodes = nodesTemp;
      relations = relationsTemp;
      nodeMap = nodeMapTemp;
    });
  }

  // partie de production
  final TransformationController _transformationController =
      TransformationController();
  int idx = 0;

  Function onDragStarted(Node key) => (x, y) {
    setState(() {
      nodeMap[key] = _transformationController.toScene(Offset(x, y));
      updateNode(key, x, y);
    });
  };

  @override
  void initState() {
    super.initState();
    // importAutomateFromWeb();
    automate = Automate(nodes: [], relations: []);
    nodes = automate.nodes;
    relations = automate.relations;
    notifierMap['automata']?.addListener(() {
      setState(() {
        automate = notifierMap['automata']?.value;
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
                    nodeMap[Node(name: 'new node ${idx}')] =
                        _transformationController.toScene(_doubleTapPosition!);
                    addNewNode('new node ${idx}', _doubleTapPosition!.dx,
                        _doubleTapPosition!.dy);
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
              // boundaryMargin: const EdgeInsets.all(2.0),
              minScale: 0.001,
              maxScale: 10.5,
              // constrained: true,
              transformationController: _transformationController,
              child: Stack(
                children: <Widget>[
                  ValueListenableBuilder<bool>(
                    builder: (BuildContext context, bool value, Widget? child) {
                      // This builder will only get called when isSelected.value is updated.
                      return Text('node tap : $value');
                    },
                    valueListenable: drawLineNotifier,
                  ),
                  ValueListenableBuilder<dynamic>(
                    builder:
                        (BuildContext context, dynamic value, Widget? child) {
                      var toprint = value.toJson();
                      return Text('automate from local : $toprint');
                    },
                    valueListenable: notifierMap['automata']!,
                  ),
                  CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter:
                        RelationPainter(nodeMap: nodeMap, relations: relations),
                  ),
                  ..._buildNodes(),
                  ..._buildLabels(),
                ],
              )),
        ));
  }

  List<Widget> _buildNodes() {
    final res = <Widget>[];
    automate.nodes.forEach((element) {
      res.add(NodeWidget(
          offset: element.offset,
          node: element,
          onDragStarted: onDragStarted(element),
          drawLineNotifier: drawLineNotifier));
    });
    return res;
  }

  List<Widget> _buildLabels() {
    final res = <Widget>[];
    automate.nodes.forEach((element) {
      res.add(NodeLabel(notifierMap: notifierMap));
    });
    return res;
  }

  void updateNode(Node key, x, y) {
    automate = notifierMap['automata']?.value;
    for (Node node in automate.nodes) {
      if (node.name == key.name) {
        node.offset = Offset(x, y);
      }
    }
    notifierMap['automata']?.value = automate;
  }

  void addNewNode(String name, double dx, double dy) {
    automate = notifierMap['automata']?.value;
    automate.nodes.add(Node(name: name, offset: Offset(dx, dy)));
    notifierMap['automata']?.value = automate;
  }

  Automate getAutomate() {
    return automate;
  }

  drawLine() {
    relations.add(Relation(source: nodes[0].name, target: nodes[3].name));
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, 0), Offset(100, 100), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
