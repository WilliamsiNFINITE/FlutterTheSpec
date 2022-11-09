class Node {

    String name;
    String invariant;
    String expIntensity;
    bool isInitial;
    bool isUrgent;
    bool isEngaged;

    Node({this.name = "", this.invariant = "", this.expIntensity = "", this.isInitial = false, this.isUrgent = false, this.isEngaged = false});

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

