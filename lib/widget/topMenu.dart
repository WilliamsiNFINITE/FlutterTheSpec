import 'package:flutter/material.dart';
import '../automate.dart';

class TopMenu extends AppBar {
  TopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.grey,
      toolbarHeight: 50,
      backgroundColor: Color.fromRGBO(220, 220, 220, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            // key: keyFile,
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
    );

  }
}
