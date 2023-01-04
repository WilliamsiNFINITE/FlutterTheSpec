import 'package:flutter/material.dart';
import '../automate.dart';

class TopMenu extends AppBar {
  TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            child: Text('Fichier', style: TextStyle(color: Colors.white)),
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
            child: Text('Edition', style: TextStyle(color: Colors.white)),
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
            child: Text('Vue', style: TextStyle(color: Colors.white)),
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
            child: Text('Outils', style: TextStyle(color: Colors.white)),
            onPressed: () {
              print('Outils');
              //
            },
          ),
          TextButton(
            child: Text('Options', style: TextStyle(color: Colors.white)),
            onPressed: () {
              print('Options');
              // TODO: implement onPressed
            },
          ),
          TextButton(
            child: Text('Aide', style: TextStyle(color: Colors.white)),
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
    );

  }
}
