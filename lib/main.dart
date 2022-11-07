import 'dart:math';

import 'package:flutter/material.dart';
import 'node.dart';
import 'nodeWidget.dart';
import 'relationPainter.dart';
import 'graphSceneState.dart';
import 'graphScene.dart';


void main() {
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




