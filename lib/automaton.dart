import 'dart:convert';
import 'dart:ui';

class Automaton {
    // List of nodes
    List<Node> nodes;
    // List of relations
    List<Relation> relations;

    Automaton({required this.nodes, required this.relations});

    factory Automaton.fromJson(Map<String, dynamic> json) {
      var nodesJson = json['nodes'] as List;
      List<Node> nodesList = nodesJson.map((node) => Node.fromJson(node)).toList();
      var relationsJson = json['relations'] as List;
      List<Relation> relationsList = relationsJson.map((relation) => Relation.fromJson(relation)).toList();
      return Automaton(nodes: nodesList, relations: relationsList);
    }

    Map<String, dynamic> toJson() {
      return {
        'nodes': nodes.map((node) => node.toJson()).toList(),
        'relations': relations.map((relation) => relation.toJson()).toList(),
      };
    }

}


class Node {

    // int id;
    String name;
    String invariant;
    String expIntensity;
    bool isInitial;
    bool isFinal;
    bool isUrgent;
    bool isEngaged;
    bool isSelected;
    Offset offset;

    //
    Node({this.name = "", this.invariant = "", this.expIntensity = "", this.isInitial = false, this.isFinal = false, this.isUrgent = false, this.isEngaged = false, this.isSelected = false, this.offset = Offset.zero});


    factory Node.fromJson(Map<String, dynamic> json) {
        var offset = json['offset'];

        return Node(
            name: json['name'],
            invariant: json['invariant'],
            expIntensity: json['expIntensity'],
            isInitial: json['isInitial'],
            isUrgent: json['isUrgent'],
            isEngaged: json['isEngaged'],
            isSelected: json['isSelected'],
            offset: Offset(offset['x'], offset['y']),
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'name': name,
            'invariant': invariant,
            'expIntensity': expIntensity,
            'isInitial': isInitial,
            'isUrgent': isUrgent,
            'isEngaged': isEngaged,
            'isSelected': isSelected,
            'offset': {'x': offset.dx, 'y': offset.dy},
        };
    }

  void addListener(Null Function() param0) {}


}

class Relation {

    // int id;
    Node source;
    Node target;
    String guard;
    String sync;
    String update;

    Relation({required this.source, required this.target, this.guard = "", this.sync = "", this.update = ""});

    factory Relation.fromJson(Map<String, dynamic> json) {
        //encode json to node

        Node source = Node.fromJson(json['source']);
        Node target = Node.fromJson(json['target']);
        return Relation(
            source: source,
            target: target,
            guard: json['guard'],
            sync: json['sync'],
            update: json['update']
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'source': source,
            'target': target,
            'guard': guard,
            'sync': sync,
            'update': update,
        };
    }
}
