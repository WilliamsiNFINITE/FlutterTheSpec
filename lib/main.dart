import 'package:flutter/material.dart';
import 'graphScene.dart';


void main() {
//
//
// // get the json file from assets folder
//   Future<String> _loadNodesAsset() async {
//     return await rootBundle.loadString('assets/nodes.json');
//   }
// // set a variable with the json file content
//   Future loadNodes() async {
//     String jsonString = await _loadNodesAsset();
//     final jsonResponse = json.decode(jsonString);
//     print(jsonResponse);
//     return jsonResponse;
//   }
//
//   var my_data_test = loadNodes();
//   print('my_data_test');
//   print(my_data_test);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false, // Remove debug banner
        title: 'Flutter The Spec',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: Center(
              child: Container(
                alignment: Alignment.center,
                decoration:
                BoxDecoration(border: Border.all(color: Colors.redAccent)),
                child: const GraphScene(),
              ),
            )));
  }
}




