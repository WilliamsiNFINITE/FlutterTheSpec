import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/leftMenu.dart';
import 'package:flutter_the_spec/widget/topMenu.dart';
import 'package:flutter_the_spec/widget/topPalette.dart';
import 'automate.dart';
import 'graphScene.dart';
import 'graphSceneState.dart';
import 'logic/export.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home() //create new class for 'home' property of MaterialApp()
      //to escape 'No MaterialLocalizations found' error
    );
  }
}

class Home extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var items;
    var onChanged;
    var valueChoose;
    late Automate automate;

    const GraphScene graphScene = GraphScene();

    return MaterialApp(
        // debugShowCheckedModeBanner: false, // Remove debug banner
        title: 'Flutter The Spec',
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   primarySwatch: Colors.blue,
        // ),
        home:  Scaffold(
          // TODO put topmenu instead of appbar
          appBar: AppBar(
            // backgroundColor: Colors.grey,
            toolbarHeight: 50,
            backgroundColor: Color.fromRGBO(220, 220, 220, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: Text('Fichier', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    //container with 4 buttons
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Fichier'),
                            content: Container(
                              height: 200,
                              width: 200,
                              child: Column(
                                children: [
                                  TextButton(
                                    child: Text('Nouveau'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Ouvrir'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Enregistrer'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Enregistrer sous'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    print('Fichier');
                    // TODO: implement onPressed
                  },
                ),
                TextButton(
                  child: Text('Edition', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Edition'),
                            content: Container(
                              height: 200,
                              width: 200,
                              child: Column(
                                children: [
                                  TextButton(
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Refaire'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Copier'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Coller'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    print('Edition');
                    // TODO: implement onPressed
                  },
                ),
                TextButton(
                  child: Text('Vue', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Vue'),
                            content: Container(
                              height: 200,
                              width: 200,
                              child: Column(
                                children: [
                                  TextButton(
                                    child: Text('Zoom'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Etiquette'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Grille'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    print('Vue');

                    // TODO: implement onPressed
                  },
                ),
                TextButton(
                  child: Text('Outils', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    print('Outils');
                    //
                  },
                ),
                TextButton(
                  child: Text('Options', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    exportAutomate(Automate(nodes: [], relations: []));
                    print(graphScene);// TODO get current automate / state
                    print('Options');
                    // TODO: implement onPressed
                  },
                ),
                TextButton(
                  child: Text('Aide', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Fichier'),
                            content: Container(
                              height: 200,
                              width: 200,
                              child: Column(
                                children: [
                                  TextButton(
                                    child: Text('A propos'),
                                    onPressed: () {
                                      //TODO
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    print('Aide');
                    // TODO: implement onPressed
                  },
                ),
              ],

            ),
          ),
          // body: GraphScene(),

          body:  Center(
            // Column  with 2 containers
            child:
            Column(
              children: [
                TopPalette(),
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
                        LeftMenu(),
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
                  //   Container(
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(border:  Border.all(color: Colors.blue)),
                  //   child: const GraphScene(),
                  // ),

            )
        )

  );
  }
}




