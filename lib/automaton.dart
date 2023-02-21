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

    String name;
    String invariant;
    String expIntensity;
    bool isInitial;
    bool isFinal;
    bool isUrgent;
    bool isEngaged;
    Offset offset;

    //
    Node({this.name = "", this.invariant = "", this.expIntensity = "", this.isInitial = false, this.isFinal = false, this.isUrgent = false, this.isEngaged = false, this.offset = Offset.zero});


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

    Map<String, dynamic> toJson() {
        return {
            'name': name,
            'invariant': invariant,
            'expIntensity': expIntensity,
            'isInitial': isInitial,
            'isUrgent': isUrgent,
            'isEngaged': isEngaged,
            'offset': {'x': offset.dx, 'y': offset.dy},
        };
    }

  void addListener(Null Function() param0) {}


}

class Relation {

    String source;
    String target;
    String guard;
    String sync;
    String update;

    Relation({required this.source, required this.target, this.guard = "", this.sync = "", this.update = ""});

    factory Relation.fromJson(Map<String, dynamic> json) {
        return Relation(
            source: json['source'],
            target: json['target'],
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
