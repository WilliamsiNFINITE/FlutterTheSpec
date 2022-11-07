import 'dart:math';

import 'package:flutter/material.dart';
import 'node.dart';
import 'graphScene.dart';
import 'nodeWidget.dart';
import 'relationPainter.dart';




class GraphSceneState extends State<GraphScene> {
  Map<Node, Offset> nodeMap = {
    Node(name: 'node 1'): const Offset(100, 150),
    Node(name: 'node 2'): const Offset(100, 200),
    Node(name: 'node 3'): const Offset(100, 250),
  };
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
