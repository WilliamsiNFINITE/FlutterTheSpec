import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_the_spec/automate.dart';

void main() {
    late var jsonTextAutomate;
    late var jsonTextRelation;
    late var jsonTextNode;

    group('Object from Json', (){
        setUp((){
            jsonTextAutomate = '{"nodes":[{"name":"node1test","invariant":"invariant1","expIntensity":"expIntensity1","isInitial":true,"isUrgent":true,"isEngaged":true,"offset":{"x":100.0,"y":300.0}},{"name":"node2test","invariant":"invariant2","expIntensity":"expIntensity2","isInitial":true,"isUrgent":true,"isEngaged":true,"offset":{"x":300.0,"y":400.0}}],"relations":[{"source":"node1test","target":"node2test","guard":"guard1","sync":"synchronisation1","update":"update1"},{"source":"node2test","target":"node3test","guard":"guard2","sync":"synchronisation2","update":"update2"}]}';
            jsonTextNode = '{"name":"node1test","invariant":"invariant1","expIntensity":"expIntensity1","isInitial":true,"isUrgent":true,"isEngaged":true,"offset":{"x":100.0,"y":300.0}}';
            jsonTextRelation = '{"source":"node1test","target":"node2test","guard":"guard1","sync":"synchronisation1","update":"update1"}';
        });

        test('Should import an automata from a json file', (){
            // Automate.fromJson
            var jsonDecoded = jsonDecode(jsonTextAutomate);
            Automate automate = Automate.fromJson(jsonDecoded);

            // Assertions on nodes
            assert(automate.nodes.length == 2);
            assert(automate.nodes[0].name == "node1test");
            assert(automate.nodes[0].invariant == "invariant1");
            assert(automate.nodes[0].expIntensity == "expIntensity1");
            assert(automate.nodes[0].isInitial == true);
            assert(automate.nodes[0].isUrgent == true);
            assert(automate.nodes[0].isEngaged == true);
            assert(automate.nodes[0].offset.dx == 100.0);
            assert(automate.nodes[0].offset.dy == 300.0);
            assert(automate.nodes[1].name == "node2test");

            // Assertions on relations
            assert(automate.relations.length == 2);
            assert(automate.relations[0].source == "node1test");
            assert(automate.relations[0].target == "node2test");
            assert(automate.relations[0].guard == "guard1");
            assert(automate.relations[0].sync == "synchronisation1");
            assert(automate.relations[0].update == "update1");
            assert(automate.relations[1].source == "node2test");

        });
        test('should import a node from a json file', (){
            // Node.fromJson
            var jsonDecoded = jsonDecode(jsonTextNode);
            Node node = Node.fromJson(jsonDecoded);

            // Assertions on nodes
            assert(node.name == "node1test");
            assert(node.invariant == "invariant1");
            assert(node.expIntensity == "expIntensity1");
            assert(node.isInitial == true);
            assert(node.isUrgent == true);
            assert(node.isEngaged == true);
            assert(node.offset.dx == 100.0);
            assert(node.offset.dy == 300.0);

        });
        test('should import relations from a json file', (){
            // Relations.fromJson
            var jsonDecoded = jsonDecode(jsonTextRelation);
            Relation relation = Relation.fromJson(jsonDecoded);

            // Assertions on relations
            assert(relation.source == "node1test");
            assert(relation.target == "node2test");
            assert(relation.guard == "guard1");
            assert(relation.sync == "synchronisation1");
            assert(relation.update == "update1");

        });
    });
}

