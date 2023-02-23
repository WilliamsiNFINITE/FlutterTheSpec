import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/relationPainter.dart';
import 'package:widget_arrows/widget_arrows.dart';
import '../../automaton.dart';

class NodeProperty extends StatefulWidget {
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final Node node;

  NodeProperty({super.key, required this.node, required this.notifierMap});

  @override
  State<StatefulWidget> createState() => NodePropertyState();
}

class NodePropertyState extends State<NodeProperty> {
  late Node node;
  late Map<String, ValueNotifier<dynamic>> notifierMap;
  var toprint;

  @override
  void initState() {
    node = widget.node;
    notifierMap = widget.notifierMap;
    notifierMap['automaton']?.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title: Text('Editer le noeud'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Nom:'),
              TextField(
                controller: TextEditingController(text: node.name),
                onChanged: (value) {
                  Node previousNode = node;
                  // update of the node
                  node.name = value;
                  // update of the relations
                  try{
                    for (var relation in notifierMap['automaton']?.value.relations) {
                      if (relation.source == previousNode) {
                        relation.source.name = value;
                      }
                      if (relation.target == previousNode) {
                        relation.target.name = value;
                      }
                    }
                  }
                  catch(e){
                    print(e);
                  }
                  print(node.name);
                },
              ),
              Text('Invariant:'),
              TextField(
                controller: TextEditingController(text: node.invariant),
                onChanged: (value) {
                  node.invariant = value;
                },
              ),
              Text('Intensité de l\'exponentielle:'),
              TextField(
                controller: TextEditingController(text: node.expIntensity),
                onChanged: (value) {
                  node.expIntensity = value;
                },
              ),
              Text('Initial:'),
              Checkbox(
                value: node.isInitial,
                onChanged: (value) {
                  setState(() {
                    node.isInitial = value!;
                  });
                },
              ),
              Text('Urgent:'),
              Checkbox(
                value: node.isUrgent,
                onChanged: (value) {
                  setState(() {
                    node.isUrgent = value!;
                    if (node.isUrgent) {
                      node.isEngaged = false;
                    }
                  });
                },
              ),

              Text('Engagé:'),
              Checkbox(
                value: node.isEngaged,
                onChanged: (value) {
                  setState(() {
                    node.isEngaged = value!;
                    if (node.isEngaged) {
                      node.isUrgent = false;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Save'),
            onPressed: () {
              Navigator.of(context).pop();
              notifierMap['automata']?.notifyListeners();
            },
          ),
        ],
      );
  }
}
