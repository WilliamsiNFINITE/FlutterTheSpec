import 'package:flutter/material.dart';
import '../automate.dart';
import '../logic/export.dart';

class TopMenu extends Container {
  TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:  Border.all(color: Colors.black),
          color: Color.fromRGBO(220, 220, 220, 1)
      ),

      height: 50,
      width: MediaQuery.of(context).size.width,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              //change hovering color to blue
              style: TextButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text('Fichier', style: TextStyle(color: Colors.black)),
              onPressed: () {
                // Afficher les 4 boutons dans un menu déroulant
                showMenu(
                    context: context,
                    // position: RelativeRect.fromRect(new Rect.fromPoints(new Offset(0.0, 55.0), new Offset(0.0, 55.0)), new Rect.fromPoints(new Offset(50.0, 5.0), new Offset(200.0, 500.0))),
                    position: RelativeRect.fromLTRB(15, 52, 15, 0), //TODO éviter de coder en dur la position du menu
                    items: ["Nouveau", "Ouvrir", "Enregistrer"].map((e) => PopupMenuItem(child: Text(e), value: e, onTap: ()=>{topMenuHandler(e, context)})).toList());
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
                // TODO: implement onPressed
              },
            ),
            TextButton(
              child: Text('Aide', style: TextStyle(color: Colors.black)),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(310, 52, 310, 0), //TODO éviter de coder en dur la position du menu
                    items: ["A propos"].map((e) => PopupMenuItem(child: Text(e), value: e, onTap: ()=>{
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("A propos"),
                              content: Text("Flutter The Spec est un logiciel de création de machines à états finis."),
                              actions: [
                                TextButton(
                                  child: Text("Fermer"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                      )
                    })).toList());

                print('Aide');
              },
            ),
          ],

        ),
      ),
    );


  }

  void topMenuHandler(String value, BuildContext context) {
    switch (value) {
      case "Nouveau":
        print("Nouveau dans fonction topMenuHandler");
        //TODO reset graphScene
        break;
      case "Ouvrir":
        print("Ouvrir dans fonction topMenuHandler");
        //TODO open file
        break;
      case "Enregistrer":
        print("Enregistrer dans fonction topMenuHandler");
        exportAutomate(Automate(nodes: [], relations: [])); //TODO save file
        break;
      case "Annuler":
        print("Annuler dans fonction topMenuHandler");
        //TODO undo
        break;
      case "Refaire":
        print("Refaire dans fonction topMenuHandler");
        //TODO redo
        break;
      case "Copier":
        print("Copier dans fonction topMenuHandler");
        //TODO copy
        break;
      case "Couper":
        print("Couper dans fonction topMenuHandler");
        //TODO cut
        break;
      case "Coller":
        print("Coller dans fonction topMenuHandler");
        //TODO paste
        break;
      case "Zoom Adapté":
        print("Zoom Adapté dans fonction topMenuHandler");
        //TODO zoom fit
        break;
      case "Zoomer":
        print("Zoomer dans fonction topMenuHandler");
        //TODO zoom in
        break;
      case "Dézoomer":
        print("Dézoomer dans fonction topMenuHandler");
        //TODO zoom out
        break;
      case "Etiquettes":
        print("Etiquettes dans fonction topMenuHandler");
        //TODO show labels
        break;
      case "Grille":
        print("Grille dans fonction topMenuHandler");
        //TODO show grid
        break;
      case "Vérifier la synthaxe":
        print("Vérifier la synthaxe dans fonction topMenuHandler");
        //TODO check syntax
        break;
      case "A propos":
        print("A propos dans fonction topMenuHandler");
        exportAutomate(Automate(nodes: [], relations: []));
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Flutter the spec'),
                content: Text('Application de création de machines à états finis'),
              );
            });

        break;
    }
  }
}
