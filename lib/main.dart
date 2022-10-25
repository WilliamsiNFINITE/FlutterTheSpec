import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: Scaffold(
            body: Center(
              child: Container(
                alignment: Alignment.center,
                decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: const GraphScene(),
              ),
            )));
  }
}

class GraphScene extends StatefulWidget {
  const GraphScene({super.key});

  @override
  State<GraphScene> createState() => _GraphSceneState();
}

class _GraphSceneState extends State<GraphScene> {
  Map<Node, Offset> nodeMap = {
    Node(name: 'node 1'): const Offset(100, 100),
    Node(name: 'node 2'): const Offset(100, 100),
    Node(name: 'node 3'): const Offset(100, 100),
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

class NodeWidget extends StatelessWidget {
  const NodeWidget(
      {super.key,
        required this.offset,
        required this.node,
        required this.onDragStarted});
  final Offset offset;
  final Node node;
  final double size = 100;
  final Function onDragStarted;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx - size / 2,
      top: offset.dy - size / 2,
      child: GestureDetector(
          onPanStart: (data) =>
              onDragStarted(data.globalPosition.dx, data.globalPosition.dy),
          onPanUpdate: (data) =>
              onDragStarted(data.globalPosition.dx, data.globalPosition.dy),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.7),
              border: Border.all(color: Colors.black),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name:'),
                  controller: TextEditingController()..text = node.name,
                  onSubmitted: (value) => node.name = value,
                )),
          )),
    );
  }
}

class RelationPainter extends CustomPainter {
  RelationPainter({required this.nodeMap});

  final Map<Node, Offset> nodeMap;

  @override
  void paint(Canvas canvas, Size size) {
    if (nodeMap.length > 1) {
      Node? previous;
      nodeMap.forEach((index, offset) {
        if (previous == null) {
          previous = index;
          return;
        }
        canvas.drawLine(
          offset,
          nodeMap[previous]!,
          Paint()
            ..color = Colors.red
            ..strokeWidth = 2,
        );
        previous = index;
      });
    }
  }

  @override
  bool shouldRepaint(RelationPainter oldDelegate) => true;
}

class Node {
  Node({this.name = ""});
  String name;
}

