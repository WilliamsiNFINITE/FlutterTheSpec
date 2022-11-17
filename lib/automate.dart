class Node {

    String name;
    String invariant;
    String expIntensity;
    bool isInitial;
    bool isUrgent;
    bool isEngaged;
    Map<String,int> offset = {
        "x" : 0,
        "y" : 0
    };

    //
    Node({this.name = "", this.invariant = "", this.expIntensity = "", this.isInitial = false, this.isUrgent = false, this.isEngaged = false, this.offset = const {"x" : 0, "y" : 0}});


    factory Node.fromJson(Map<String, dynamic> json) {
        var obj = json['offset'];

        return Node(
            name: json['name'],
            invariant: json['invariant'],
            expIntensity: json['expIntensity'],
            isInitial: json['isInitial'],
            isUrgent: json['isUrgent'],
            isEngaged: json['isEngaged'],
            offset: {
                "x" : obj['x'],
                "y" : obj['y']
            }
        );
    }

}

class NodeTest{

    String name;
    Map<String, int> offset = {
        "x" : 0,
        "y" : 0
    };


    NodeTest({this.name = "", this.offset = const {"x" : 0, "y" : 0}});

    factory NodeTest.fromJson(Map<String, dynamic> json) {
        var offset = json['offset'];
        return NodeTest(
            name: json['name'],
            offset: {
                "x" : offset['x'],
                "y" : offset['y']
            }
        );
    }

}


class Relation {

    Node from;
    Node to;
    String guard;
    String sync;
    String update;

    Relation({required this.from, required this.to, this.guard = "", this.sync = "", this.update = ""});

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

