import 'dart:convert';
import 'package:flutter/material.dart';
import 'automate.dart';
import 'graphScene.dart';
import 'nodeWidget.dart';
import 'relationPainter.dart';
// import to read data from internet
import 'package:http/http.dart' as http;


class GraphSceneState extends State<GraphScene> {

  Future<Map<String,dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://dl.dropbox.com/s/e2886piklyftecv/nodes.json?dl=0'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get the data');
    }
  }

  createNodeMap() async{

    var automate = await fetchData();
    var nodes = automate['nodes'];
    var relations = automate['relations'];

    // créer un map des nodes
    Map<Node, Offset> nodeMapTest = {};
    // ajouter les nodes au map
    for (int i = 0; i < nodes.length; i++) {
      nodeMapTest[Node(name: nodes[i]['name'])] = Offset( nodes[i]['offset']['x'],nodes[i]['offset']['y']);
    }
    setState(() {
      testNodeMap = nodeMapTest;
    });
  }

  Map<Node, Offset> testNodeMap = {};

  // partie de production
  final TransformationController _transformationController = TransformationController();
  int idx = 1;

  Function onDragStarted(Node key) => (x, y) {
    setState(() {
      testNodeMap[key] = _transformationController.toScene(Offset(x, y));
    });
  };

  @override
  void initState() {
    super.initState();
    createNodeMap();
    // importAutomate();

  }

  Offset? _doubleTapPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {testNodeMap.forEach((node, offset) => print(node.name))},
        onDoubleTap: () {
          setState(() {
            testNodeMap[Node(name: 'node ${idx++}')] = _transformationController.toScene(_doubleTapPosition!);
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
                    painter: RelationPainter(nodeMap: testNodeMap),
                  ),
                  ..._buildNodes(),
                ],
              )),
        ));
  }

  List<Widget> _buildNodes() {
    final res = <Widget>[];
    testNodeMap.forEach((node, offset) {
      res.add(NodeWidget(
          offset: offset, node: node, onDragStarted: onDragStarted(node)));
    });
    return res;
  }
}
