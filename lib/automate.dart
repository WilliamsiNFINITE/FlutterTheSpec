import 'dart:ui';

class Automate {
    // List of nodes
    List<Node> nodes;
    // List of relations
    List<Relation> relations;

    Automate({required this.nodes, required this.relations});

    factory Automate.fromJson(Map<String, dynamic> json) {
      var nodesJson = json['nodes'] as List;
      List<Node> nodesList = nodesJson.map((node) => Node.fromJson(node)).toList();
      var relationsJson = json['relations'] as List;
      List<Relation> relationsList = relationsJson.map((relation) => Relation.fromJson(relation)).toList();
      return Automate(nodes: nodesList, relations: relationsList);
    }

}


class Node {

    String name;
    String invariant;
    String expIntensity;
    bool isInitial;
    bool isUrgent;
    bool isEngaged;
    Offset offset;

    //
    Node({this.name = "", this.invariant = "", this.expIntensity = "", this.isInitial = false, this.isUrgent = false, this.isEngaged = false, this.offset = Offset.zero});


    factory Node.fromJson(Map<String, dynamic> json) {
        var offset = json['offset'];

        return Node(
            name: json['name'],
            invariant: json['invariant'],
            expIntensity: json['expIntensity'],
            isInitial: json['isInitial'],
            isUrgent: json['isUrgent'],
            isEngaged: json['isEngaged'],
            offset: Offset(offset['x'], offset['y']),
        );
    }

}

class NodeTest{

    String name;
    Offset offset;

    NodeTest({this.name = "", this.offset = Offset.zero});

    factory NodeTest.fromJson(Map<String, dynamic> json) {
        var offset = json['offset'];
        return NodeTest(
            name: json['name'],
            offset: Offset(offset['x'], offset['y']),
        );
    }

}


class Relation {

    Node source;
    Node target;
    String guard;
    String sync;
    String update;

    Relation(
        {required this.source, required this.target, this.guard = "", this.sync = "", this.update = ""});

    factory Relation.fromJson(Map<String, dynamic> json) {
        return Relation(
            source: Node.fromJson(json['source']),
            target: Node.fromJson(json['target']),
            guard: json['guard'],
            sync: json['sync'],
            update: json['update']
        );
    }
}

class RelationTest{

      NodeTest source;
      NodeTest target;
      RelationTest({required this.source, required this.target});

      factory RelationTest.fromJson(Map<String, dynamic> json) {
          return RelationTest(
              source: json['source'],
              target: json['target']
          );
      }

}

class Predecessor {

    Node node;
    Relation relation;

    Predecessor({required this.node, required this.relation});

}

class Successor {

    Node node;
    Relation relation;

    Successor({required this.node, required this.relation});

}

