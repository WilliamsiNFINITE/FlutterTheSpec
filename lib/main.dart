import 'dart:html';

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
    var items;
    var onChanged;
    var valueChoose;
    late Automate automate;
    GlobalKey keyFile = GlobalKey();
    final keyGraphScene = new GlobalKey<GraphSceneState>();

    const GraphScene graphScene = GraphScene();
    // const GraphScene graphScene = GraphScene(key: keyGraphScene);

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
            Column(// TODO le modifier pour en faire un stateful widget qui va pouvoir modifier les etat et les partager
              children: [
                TopMenu(),
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
            )
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
