import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_the_spec/widget/graph/graphSceneState.dart';

void main() {
    setUp((){

    });
    group('First Tests', (){
        test('1 should be equal to 1', (){
            expect(1,1);
        });

        test('2 should not be equal to 1',(){
            expect(2!=1, true);
        });

    });


    // group('Methods', (){
    //     void setUp(){
    //         graphScene //TODO init graphScene
    //     };
    //
    //
    //     test('the method to update nodes should change the offset of the node given in parameter'){
    //         x = 0;
    //         y = 1;
    //         node = Node() //TODO fill the node constructor
    //         updateNode(node,x,y)
    //         expect(node.offset, Offset(x,y));
    //     });
    //     test('the method to update the automata should update nodes and relations'){
    //         initAutomata = Automate() //TODO constructor
    //
    //     });
    // });


}

