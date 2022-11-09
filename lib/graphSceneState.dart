import 'dart:convert';
import 'package:flutter/material.dart';
import 'node.dart';
import 'graphScene.dart';
import 'nodeWidget.dart';
import 'relationPainter.dart';

const String data = '''{
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
                    "x" : 200,
                    "y" : 400
                }
        }
    ]
}''';

// var my_data = json.decode(data);
var my_data = json.decode(data);

// intialize nodeMap
Map<Node, Offset> nodeMap = {
};

// add nodes to nodeMap using the data from the json file with loadNodes()




int addNodes(){
  //add the nodes from my_data to the nodeMap
  for (var i = 0; i < my_data['nodes'].length; i++) {
    nodeMap[Node(name: my_data['nodes'][i]['name'])] = Offset( my_data['nodes'][i]['offset']['x'],my_data['nodes'][i]['offset']['y']);
  }
  return 1;
}

class GraphSceneState extends State<GraphScene> {
  // Open the file nodes.json


  int a = addNodes();

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
