import 'dart:convert';
import 'package:flutter/material.dart';
import 'automate.dart';
import 'graphScene.dart';
import 'widget/nodeWidget.dart';
import 'relationPainter.dart';
// import to read data from internet
import 'package:http/http.dart' as http;


class GraphSceneState extends State<GraphScene> {

  Map<Node, Offset> nodeMap = {};
  late List<Node> nodes;
  late List<Relation> relations;
  late Automate automate;

  Future<Map<String,dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://dl.dropbox.com/s/e2886piklyftecv/nodes.json?dl=0'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get the data');
    }
  }

  importAutomate() async {
    Map<String,dynamic> data = await fetchData();

    var automateTemp = Automate.fromJson(data);
    var nodesTemp = automateTemp.nodes;
    var relationsTemp = automateTemp.relations;
    Map<Node, Offset> nodeMapTemp = {};

    for (Node node in nodesTemp) {
      nodeMapTemp[node] = Offset( node.offset.dx,node.offset.dy);
    }

    setState(() {
      automate = automateTemp;
      nodes = nodesTemp;
      relations = relationsTemp;
      nodeMap = nodeMapTemp;
    });
  }

  // partie de production
  final TransformationController _transformationController = TransformationController();
  int idx = 1;

  Function onDragStarted(Node key) => (x, y) {
    setState(() {
      nodeMap[key] = _transformationController.toScene(Offset(x, y));
    });
  };

  @override
  void initState() {
    super.initState();
    importAutomate();
  }

  Offset? _doubleTapPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {nodeMap.forEach((node, offset) => print(node.name))},
        onDoubleTap: () {
          setState(() {
            nodeMap[Node(name: 'node ${idx++}')] = _transformationController.toScene(_doubleTapPosition!);
          });
        },
        onDoubleTapDown: (details) {
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
                  CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: RelationPainter(nodeMap: nodeMap),
                  ),
                  ..._buildNodes(),
                ],
              )),
        ));
  }

  List<Widget> _buildNodes() {
    final res = <Widget>[];
    nodeMap.forEach((node, offset) {
      res.add(NodeWidget(
          offset: offset, node: node, onDragStarted: onDragStarted(node)));
    });
    return res;
  }
}
