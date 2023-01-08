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
          // TODO put topmenu instead of appbar
          appBar: AppBar(
            // backgroundColor: Colors.grey,
            toolbarHeight: 50,
            backgroundColor: Color.fromRGBO(220, 220, 220, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  key: keyFile,
                  child: Text('Fichier', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    // Afficher les 4 boutons dans un menu déroulant
                    showMenu(
                        context: context,
                        // position: RelativeRect.fromRect(new Rect.fromPoints(new Offset(0.0, 55.0), new Offset(0.0, 55.0)), new Rect.fromPoints(new Offset(50.0, 5.0), new Offset(200.0, 500.0))),
                        position: RelativeRect.fromLTRB(15, 52, 15, 0), //TODO éviter de coder en dur la position du menu
                        items: ["Nouveau", "Ouvrir", "Enregistrer sous"].map((e) => PopupMenuItem(child: Text(e), value: e)).toList());

                    print('Fichier');
                  },
                ),
                TextButton(
                  child: Text('Edition', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(75, 52, 75, 0), //TODO éviter de coder en dur la position du menu
                        items: ["Annuler", "Refaire", "Copier", "Couper", "Coller"].map((e) => PopupMenuItem(child: Text(e), value: e)).toList());

                    print('Edition');
                  },
                ),
                TextButton(
                  child: Text('Vue', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(135, 52, 135, 0), //TODO éviter de coder en dur la position du menu
                        items: ["Zoom Adapté", "Zoomer", "Dézoomer", "Etiquettes", "Grille"].map((e) => PopupMenuItem(child: Text(e), value: e)).toList());

                    print('Vue');
                  },
                ),
                TextButton(
                  child: Text('Outils', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(190, 52, 190, 0), //TODO éviter de coder en dur la position du menu
                        items: ["Vérifier la synthaxe"].map((e) => PopupMenuItem(child: Text(e), value: e)).toList());

                    print('Outils');
                  },
                ),
                TextButton(
                  child: Text('Options', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    //get the automate from graphScene
                    automate = graphScene.getAutomate();
                    exportAutomate(automate);
                    // TODO: implement onPressed
                  },
                ),
                TextButton(
                  child: Text('Aide', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(310, 52, 310, 0), //TODO éviter de coder en dur la position du menu
                        items: ["A propos"].map((e) => PopupMenuItem(child: Text(e), value: e)).toList());

                    print('Aide');
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

  double getLeftValue(key) {
    RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double yEdition = position.dy; //this is y - I think it's what you want
    print(yEdition);
    return yEdition;
  }
}






// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// final key = GlobalKey<MyStatefulWidget1State>();
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             MyStatefulWidget1(key: key),
//             MyStatefulWidget2(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MyStatefulWidget1 extends StatefulWidget {
//   MyStatefulWidget1({ required Key key }) : super(key: key);
//   State createState() => MyStatefulWidget1State();
// }
//
// class MyStatefulWidget1State extends State<MyStatefulWidget1> {
//   String _createdObject = "Hello world!";
//   String get createdObject => _createdObject;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(_createdObject),
//     );
//   }
// }
//
// class MyStatefulWidget2 extends StatefulWidget {
//   State createState() => MyStatefulWidget2State();
// }
//
// class MyStatefulWidget2State extends State<MyStatefulWidget2> {
//   String _text = 'PRESS ME';
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         child: Text(_text),
//         onPressed: () {
//           setState(() {
//             _text = key.currentState!.createdObject;
//           });
//         },
//       ),
//     );
//   }
// }