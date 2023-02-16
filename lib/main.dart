import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/codeEditor.dart';
import 'package:flutter_the_spec/widget/leftMenu.dart';
import 'package:flutter_the_spec/widget/topMenu.dart';
import 'package:flutter_the_spec/widget/topPalette.dart';
import 'automaton.dart';
import 'widget/graph/graphScene.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: useMaterial3 : true; --> pour utiliser Iconbutton. avoir isSelected
        home: Home() //create new class for 'home' property of MaterialApp()
      //to escape 'No MaterialLocalizations found' error
    );
  }
}

class Home extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // map containing dynamic value notifier
    Map<String, ValueNotifier<dynamic>> notifierMap = {};

    //topPalette Buttons
    notifierMap['newButton'] = ValueNotifier<bool>(false);
    notifierMap['openButton'] = ValueNotifier<bool>(false);
    notifierMap['downloadButton'] = ValueNotifier<bool>(false);
    notifierMap['undoButton'] = ValueNotifier<bool>(false);
    notifierMap['redoButton'] = ValueNotifier<bool>(false);
    notifierMap['adaptedZoomButton'] = ValueNotifier<bool>(false);
    notifierMap['zoomInButton'] = ValueNotifier<bool>(false);
    notifierMap['zoomOutButton'] = ValueNotifier<bool>(false);
    notifierMap['selectButton'] = ValueNotifier<bool>(false);
    notifierMap['addNodeButton'] = ValueNotifier<bool>(false);
    notifierMap['addRelationButton'] = ValueNotifier<bool>(false);

    // Automata
    notifierMap['automata'] = ValueNotifier<dynamic>(Automaton(nodes: [], relations: []));

    // Active editing widget
    notifierMap['activeEditingWidget'] = ValueNotifier<bool>(true);

    // GraphScene
    notifierMap['drawLineNotifier'] = ValueNotifier(false);
    notifierMap['beginNode'] = ValueNotifier<Node>(Node(name: 'begin node'));
    notifierMap['endNode'] = ValueNotifier<Node>(Node(name: 'end node'));


    // Main widgets
    final TopPalette topPalette = TopPalette(notifierMap: notifierMap);
    final LeftMenu leftMenu = LeftMenu();
    final TopMenu topMenu = TopMenu();
    GraphScene graphScene = GraphScene(notifierMap: notifierMap);
    final CodeEditor codeEditor = CodeEditor(notifierMap: notifierMap);


    return MaterialApp(
        // debugShowCheckedModeBanner: false, // Remove debug banner
        title: 'Flutter The Spec',
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   primarySwatch: Colors.blue,
        // ),
        home:  Scaffold(
          body:  Center(
            // Column  with 2 containers
            child:
            Column(// Ici, le parent des widgets que je vais utiliser pour les notifier // TODO le modifier pour en faire un stateful widget qui va pouvoir modifier les etat et les partager
              children: [
                topMenu,
                topPalette,
                Container(
                  decoration: BoxDecoration(
                      border:  Border.all(color: Colors.black),
                      // color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    <Widget>[
                      Expanded( //Left MENU
                        flex: 1,
                        child:
                        leftMenu,
                      ),

                      Expanded( //GraphScene
                        flex: 9,
                        child:
                        Container(
                          height: MediaQuery.of(context).size.height-102, //size of toolbar and palette
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border:  Border.all(color: Colors.black)),
                          child: ValueListenableBuilder<dynamic>(
                            builder: (BuildContext context, dynamic value, Widget? child) {// print('valueSelected in main : $value');
                              return
                              Container(
                                  child: AnimatedCrossFade(
                                  firstChild: graphScene,
                                  secondChild: codeEditor,
                                  crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 50),
                                )
                              );
                            },
                            valueListenable: notifierMap['activeEditingWidget']!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.cached, color: Colors.black),
            onPressed: () => {
              notifierMap['activeEditingWidget']?.value = !notifierMap['activeEditingWidget']?.value,
            }
          ),
        )

  );
  }

  // double getLeftValue(key) {
  //   RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
  //   Offset position = box.localToGlobal(Offset.zero); //this is global position
  //   double yEdition = position.dy; //this is y
  //   print(yEdition);
  //   return yEdition;
  // }
}
