import 'package:flutter/material.dart';
import '../automate.dart';
import '../logic/export.dart';

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
                child: IconButton(
                  icon: const Icon(Icons.create_new_folder),
                  tooltip: 'Nouveau',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.file_open),
                  tooltip: 'Ouvrir',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.save_alt),
                  tooltip: 'Télécharger',
                  onPressed: () {
                    exportAutomate(new Automate(nodes: [], relations: []));
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Annuler',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Refaire',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.settings_overscan),
                  tooltip: 'Zoom adapté',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.zoom_in),
                  tooltip: 'Zoomer',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.zoom_out),
                  tooltip: 'Dézoomer',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.back_hand),
                  tooltip: 'Outil de sélection',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.circle),
                  tooltip: 'Ajouter un noeud',
                  onPressed: () {
                    //TODO
                  },
                ),
              ),
              Container(
                //width 100
                width: 100,
                child: IconButton(
                  icon: const Icon(Icons.share),
                  tooltip: 'Ajouter un arc',
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
