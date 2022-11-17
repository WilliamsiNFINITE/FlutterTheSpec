import 'dart:convert';
import 'package:flutter/material.dart';
import 'automate.dart';
import 'graphScene.dart';
import 'nodeWidget.dart';
import 'relationPainter.dart';
// // import to read data from internet
// import 'package:http/http.dart' as http;


const String data =
'''{
    "nodes":[
        {
            "name": "node1test",
            "offset":
                {
                    "x" : 100,
                    "y" : 300
                }
        },
        {
            "name": "node2test",
            "offset":
                {
                    "x" : 300,
                    "y" : 400
                }
        },
        {
            "name": "node2test",
            "offset":
                {
                    "x" : 300,
                    "y" : 400
                }
        }
    ]
}''';

// var myData = json.decode(data);
var myData = json.decode(data);
// intialize nodeMap
Map<Node, Offset> nodeMap = {
};
// add nodes to nodeMap using the data from the json file with loadNodes()
int addNodes(){
  //add the nodes from myData to the nodeMap
  for (int i = 0; i < myData['nodes'].length; i++) {
    nodeMap[Node(name: myData['nodes'][i]['name'])] = Offset( myData['nodes'][i]['offset']['x'],myData['nodes'][i]['offset']['y']);
  }
  print(nodeMap);
  return 0;
}

class GraphSceneState extends State<GraphScene> {

  var a = addNodes();

  final TransformationController _transformationController =
  TransformationController();

  int idx = 4;

  Function onDragStarted(Node key) => (x, y) {
    setState(() {
      nodeMap[key] = _transformationController.toScene(Offset(x, y));
    });
  };

  Offset? _doubleTapPosition;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {nodeMap.forEach((node, offset) => print(node.name))},
        onDoubleTap: () {
          setState(() {
            nodeMap[Node(name: 'node ${idx++}')] =
                _transformationController.toScene(_doubleTapPosition!);
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
                  ..._buildNodes()
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
