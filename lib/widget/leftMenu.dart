import 'package:flutter/material.dart';
import '../automaton.dart';

class LeftMenu extends Container {
  LeftMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Color.fromRGBO(220, 220, 220, 1),
        decoration: BoxDecoration(
            border:  Border.all(color: Colors.black),
            color: Color.fromRGBO(220, 220, 220, 1)
        ),
        height: MediaQuery.of(context).size.height-102,
        child: Column(
          //align element at the top
          children: [
            Container(
              child: TextButton(
                child: Text('Projet'),
                onPressed: () {
                  //TODO
                },
              ),
            ),
            Container(
              child: TextButton(
                child: Text('Declaration'),
                onPressed: () {
                  //TODO
                },
              ),
            ),

          ],
        ),
      );

  }
}
