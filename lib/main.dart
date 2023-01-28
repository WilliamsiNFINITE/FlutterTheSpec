import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/leftMenu.dart';
import 'package:flutter_the_spec/widget/topMenu.dart';
import 'package:flutter_the_spec/widget/topPalette.dart';
import 'automate.dart';
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
  var toprint;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // Notifier that will be used to notify the graphSceneState that a button from the palette has been pressed
    // 0 = new, 1 = open, 2 = download, 3 = undo, 4 = redo, 5 = adaptedZoom, 6 = zoomIn, 7 = zoomOut, 8 = select, 9 = addNode, 10 = addRelation
    List<ValueNotifier<dynamic>> notifierList = List<ValueNotifier<dynamic>>.empty(growable: true);
    // notifier for the topPalette
    for (int i = 0; i < 11; i++){
      notifierList.add(ValueNotifier(false));
    }
    // notifier for the graphSceneState
    // 11 = automate
    ValueNotifier<dynamic> automateNotifier = ValueNotifier<dynamic>(Automate(nodes: [], relations: []));
    notifierList.add(automateNotifier);


    // Main widgets
    final TopPalette topPalette = TopPalette(notifierList: notifierList);
    final LeftMenu leftMenu = LeftMenu();
    final TopMenu topMenu = TopMenu();
    final GraphScene graphScene = GraphScene(notifierList: notifierList);

    return MaterialApp(
        // debugShowCheckedModeBanner: false, // Remove debug banner
        title: 'Flutter The Spec',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
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
                          child: graphScene,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.cached),
            onPressed: () => {
              notifierList[0].value = !notifierList[0].value,
              toprint = notifierList[0].value,
              print('valueSelected in main : $toprint'),
            }
          ),
        )

  );
  }

  double getLeftValue(key) {
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double yEdition = position.dy; //this is y - I think it's what you want
    print(yEdition);
    return yEdition;
  }
}
