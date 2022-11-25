import 'package:flutter/foundation.dart';
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
    var items;
    var onChanged;
    var valueChoose;



    return MaterialApp(
        // debugShowCheckedModeBanner: false, // Remove debug banner
        title: 'Flutter The Spec',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home:  Scaffold(
          appBar: AppBar(
            title: const Text('Flutter the Spec'),
            actions: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child:DropdownButton(
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  hint: const Text('File'),
                  dropdownColor: Colors.grey,
                  icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                  isExpanded: false,
                  value: valueChoose,
                  items: items,
                  onChanged: (value) { if (kDebugMode) {
                    print("coucou");
                  } },

                ),
              ),

              Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    // child with a text centerd
                    child: const Text(
                      'About',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  )
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                        Icons.more_vert
                    ),
                  )
              ),

            ],
          ),

          // body: GraphScene(),

          body:  Center(
              child:  Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(border:  Border.all(color: Colors.blue)),
                child: const GraphScene(),
              ),

            )
        )
    );
  }
}




