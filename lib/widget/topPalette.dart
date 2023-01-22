import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../automate.dart';
import '../logic/export.dart';


class PaletteButton extends StatefulWidget {
  @override
  PaletteButtonState createState() => new PaletteButtonState();
}

class PaletteButtonState extends State<PaletteButton> {
  bool isPressed = false;

  void onPressedForStateButton(){
    setState(() {
      if (isPressed){isPressed = false;}
      else isPressed = true;
    });
    print('isPressed = $isPressed');
  }


  @override
  Widget build(BuildContext context) {
    // final ColorScheme colors = Theme.of(context).colorScheme;
    return IconButton(
      icon: const Icon(Icons.file_open),
      tooltip: 'Ouvrir',
      onPressed: () async {
        onPressedForStateButton();
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
        if(result != null){
          var bytesFile = result.files.single.bytes;
          var jsonText = String.fromCharCodes(bytesFile!);
          Automate automate = Automate.fromJson(jsonDecode(jsonText));
          print(automate.toJson());
          print('Import réussi');
        }
        else{
          print('Import échoué');
        }
      },
      style: IconButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.blue,
        disabledBackgroundColor: Colors.greenAccent,
        hoverColor: Colors.red.withOpacity(0.08),
        focusColor: Colors.red.withOpacity(0.12),
        highlightColor: Colors.red.withOpacity(0.12),
      ),
    );
  }
}





class TopPalette extends Container {
  TopPalette({super.key});

  File? jsonFile;

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
                child:
                PaletteButton(), //TODO : include 'type' in constructor to know which button to create
                // TODO : create a class for each button
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
