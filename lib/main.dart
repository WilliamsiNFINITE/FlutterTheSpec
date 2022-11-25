import 'package:flutter/material.dart';
import 'graphScene.dart';


Future<void> main() async {
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
        home:  Scaffold(

          // body: GraphScene(),

          body:  Center(
              child:  Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(border:  Border.all(color: Colors.blue)),
                child: const GraphScene(),
              ),
            )
            // body: Center(child: Text('You have pressed the button 0 times.')),

        )
    );
  }
}




