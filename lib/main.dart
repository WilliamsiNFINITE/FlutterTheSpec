import 'dart:convert';

import 'package:flutter/material.dart';
import 'graphScene.dart';
import 'automate.dart';
import 'package:http/http.dart' as http;



Future<Map<String,dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('https://dl.dropbox.com/s/e2886piklyftecv/nodes.json?dl=0'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to get the data');
  }
}

//use the function fetchData() to get the data from the internet in a variable called datatest

Future<Map<String, dynamic>> getData() async {
  var data = await fetchData();
  print(data);
  return data;
}

Future<NodeTest> dataToNode() async {
  var response = await http.get(Uri.parse('https://dl.dropbox.com/s/e2886piklyftecv/nodes.json?dl=0'));
  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    NodeTest nodeTest = NodeTest.fromJson(body);
    // print(nodeTest.name);
    return nodeTest;
  } else {
    throw Exception('Failed to get the data');
  }
}


void main() {

  Future<NodeTest> nodeTest = dataToNode();
  // print(nodeTest.nodes.toString()); // LE PROBLEME EST QUE LE JSON CONTIENT UN MAP DE NODES ET NON UN NODE
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
        home: const Scaffold(

          body: GraphScene(),

            // body: Center(
            //   child: Container(
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
            //     child: const GraphScene(),
            //   ),
            // )

            // body: Center(child: Text('You have pressed the button 0 times.')),

        )
    );
  }
}




