import 'dart:convert';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/nodeLabel.dart';
import '../../automaton.dart';
import '../nodeWidget.dart';
import '../relationWidget.dart';
import 'graphScene.dart';
import '../relationPainter.dart';
// import to read data from internet
import 'package:http/http.dart' as http;

class GraphSceneState extends State<GraphScene> {
  late Map<String, ValueNotifier<dynamic>> notifierMap = widget.notifierMap;

  Map<Node, Offset> nodeMap = {};
  List<Node> nodes = [];
  List<Relation> relations = [];
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
    automate = Automaton(nodes: [], relations: []);
    nodes = automate.nodes;
    relations = automate.relations;
    Map<Node, Offset> nodeMapTemp = {};


    // Delete this part the following 4 lines to start with blank graph
    // var jsonTextAutomate = '{"nodes":[{"name":"node1test","invariant":"invariant1","expIntensity":"expIntensity1","isInitial":true,"isUrgent":true,"isEngaged":true,"offset":{"x":100.0,"y":300.0}},{"name":"node2test","invariant":"invariant2","expIntensity":"expIntensity2","isInitial":true,"isUrgent":true,"isEngaged":true,"offset":{"x":300.0,"y":400.0}}],"relations":[{"source":"node1test","target":"node2test","guard":"guard1","sync":"synchronisation1","update":"update1"}]}';
    // var jsonDecoded = jsonDecode(jsonTextAutomate);
    // automate = Automaton.fromJson(jsonDecoded);
    //
    // for (Node node in automate.nodes) {
    //   nodeMapTemp[node] = Offset(node.offset.dx, node.offset.dy);
    // }
    // setState(() {
    //   nodes = automate.nodes;
    //   relations = automate.relations;
    //   nodeMap = nodeMapTemp;
    // });


    notifierMap['automata']?.addListener(() {
      setState(() {
        automate = notifierMap['automata']?.value;
        nodes = automate.nodes;
        relations = automate.relations;
        for (Node node in nodes) {
          nodeMapTemp[node] = Offset(node.offset.dx, node.offset.dy);
        }
        nodeMap  = nodeMapTemp;
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
                    print('tap graphSceneState up');

                    nodeMap[Node(name: 'new node ${idx}')] = _transformationController.toScene(_doubleTapPosition!);
                    addNewNode('new node ${idx}', _doubleTapPosition!.dx, _doubleTapPosition!.dy);
                    idx++;
                    print('tap graphSceneState down');
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
              child: Stack(
                children: <Widget>[

                  ValueListenableBuilder<dynamic>(
                    builder: (BuildContext context, dynamic value, Widget? child) {
                      automate = value;
                      nodeMap = {};
                      for (Node node in automate.nodes) {
                        nodeMap[node] = Offset(node.offset.dx, node.offset.dy);
                      }
                      relations = automate.relations;
                      return CustomPaint(
                        size: const Size(double.infinity, double.infinity),
                        painter: RelationPainter(nodeMap: nodeMap, relations: relations),
                      );
                    },
                    valueListenable: notifierMap['automata']!,
                  ),

                  ..._buildNodes(),
                  ..._buildLabels(),
                  // ..._buildRelations(),
                ],
              )),
        ));
  }

  List<Widget> _buildNodes() {
    final res = <Widget>[];
    automate.nodes.forEach((nodeToBuild) {
      res.add(NodeWidget(
          offset: nodeToBuild.offset,
          node: nodeToBuild,
          onDragStarted: onDragStarted(nodeToBuild),
          notifierMap: notifierMap));
    });
    // notifierMap['automata']?.notifyListeners();
    return res;
  }

  List<Widget> _buildLabels() {
    final res = <Widget>[];
    automate.nodes.forEach((node) {
      res.add(NodeLabel(notifierMap: notifierMap));
    });
    return res;
  }

  List<Widget> _buildRelations() {
    final res = <Widget>[];
    automate.relations.forEach((relation) {
      res.add(RelationWidget(
          relation: relation,
          notifierMap: notifierMap));
    });
    return res;
  }
  // List<Widget> _buildRelations() {
  //   final res = <Widget>[];
  //   automate.nodes.forEach((nodeToBuild) {
  //     res.add(NodeWidget(
  //         offset: nodeToBuild.offset + Offset(0, 50),
  //         node: nodeToBuild,
  //         onDragStarted: onDragStarted(nodeToBuild),
  //         notifierMap: notifierMap));
  //   });
  //   return res;
  // }


  void updateNode(Node key, x, y) {
    automate = notifierMap['automata']?.value;
    for (Node node in automate.nodes) {
      if (node.name == key.name) {
        node.offset = Offset(x, y);
      }
    }
    // notifierMap['automata']?.notifyListeners(); // not required
  }

  void addNewNode(String name, double dx, double dy) {
    automate = notifierMap['automata']?.value;
    automate.nodes.add(Node(name: name, offset: Offset(dx, dy)));
    // notifierMap['automata']?.value = automate; // not required
  }
}
