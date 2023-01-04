import 'package:flutter/material.dart';
import '../automate.dart';

class TopPalette extends Container {
  TopPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        //red background
        color: Color.fromRGBO(220, 220, 220, 1),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Nouveau', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Ouvrir'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Enregistrer sous'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Refaire'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Zoom A'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Zoom +'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Zoom -'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Selection'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Noeud'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: TextButton(
                  child: Text('Relation'),
                  onPressed: () {
                    //TODO
                  },
                ),
              ),

            ],
          ),
        )
      );

  }
}
