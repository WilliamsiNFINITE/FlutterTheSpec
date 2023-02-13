import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../automaton.dart';
import '../logic/export.dart';


class PaletteButton extends StatefulWidget{
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final String buttonType;
  PaletteButton({super.key, required this.buttonType, required this.notifierMap});

  @override
  PaletteButtonState createState() => new PaletteButtonState();
}

class PaletteButtonState extends State<PaletteButton>{
  late Map<String, ValueNotifier<dynamic>> notifierMap = widget.notifierMap;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // test to get the right button
    switch (widget.buttonType) {
      case 'new':
        return newButton(notifierMap);
      case 'download':
        return downloadButton(notifierMap);
      case 'open':
        return openButton(notifierMap);
      case 'undo':
        return undoButton(notifierMap);
      case 'redo':
        return redoButton(notifierMap);
      case 'adaptedZoom':
        return adaptedZoomButton(notifierMap);
      case 'zoomIn':
        return zoomInButton(notifierMap);
      case 'zoomOut':
        return zoomOutButton(notifierMap);
      case 'select':
        return selectButton(notifierMap);
      case 'addNode':
        return addNodeButton(notifierMap);
      case 'addRelation':
        return addRelationButton(notifierMap);
      default:
        return Container();
    }
  }

  var buttonStyle = IconButton.styleFrom(
    foregroundColor: Colors.red,
    backgroundColor: Colors.blue,
    disabledBackgroundColor: Colors.greenAccent,
    hoverColor: Colors.red.withOpacity(0.08),
    focusColor: Colors.red.withOpacity(0.12),
    highlightColor: Colors.red.withOpacity(0.12),
  );

  Widget newButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      IconButton(
        icon: const Icon(Icons.add),
        tooltip: 'Nouveau',
        onPressed: () {
          notifierMap['newButton']?.value = !notifierMap['newButton']?.value;
          notifierMap['automata']?.value = Automaton(nodes: [], relations: []);
        },
        highlightColor : Colors.blue.shade100,
      );
  }

  Widget openButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      IconButton(
      icon: const Icon(Icons.file_open),
      tooltip: 'Ouvrir',
      onPressed: () async {
          notifierMap['openButton']?.value = !notifierMap['openButton']?.value; //Button turned to true
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['json'],
          );
          if(result != null){
            var bytesFile = result.files.single.bytes;
            var jsonText = String.fromCharCodes(bytesFile!);
            Automaton automate = Automaton.fromJson(jsonDecode(jsonText));

            notifierMap['automata']?.value = automate;

            print(notifierMap['automata']?.value.toJson());
            print('Import réussi');
          }
          else{
            print('Import échoué');
          }
          // notifierMap['openButton']?.value = !notifierMap['openButton']?.value; //Button turned to false
      },
      highlightColor : Colors.blue.shade100,
    );
  }

  Widget downloadButton(Map<String, ValueNotifier<dynamic>> notifierMap) {

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Télécharger',
      onPressed: () {
        notifierMap['downloadButton']?.value = !notifierMap['downloadButton']?.value;
        exportAutomate(notifierMap['automata']?.value);
        print('Télécharger');
      },
      style: buttonStyle,
    );
  }

  Widget undoButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return IconButton(
      icon: const Icon(Icons.undo),
      tooltip: 'Annuler',
      onPressed: () {
        notifierMap['undoButton']?.value = !notifierMap['undoButton']?.value;
        print('Annuler');
      },
      style: buttonStyle,
    );
  }

  Widget redoButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return IconButton(
      icon: const Icon(Icons.redo),
      tooltip: 'Rétablir',
      onPressed: () {
        notifierMap['redoButton']?.value = !notifierMap['redoButton']?.value;
        print('Rétablir');
      },
      style: buttonStyle,
    );
  }

  Widget adaptedZoomButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return IconButton(
      icon: const Icon(Icons.zoom_out_map),
      tooltip: 'Zoom adapté',
      onPressed: () {
        notifierMap['adaptedZoomButton']?.value = !notifierMap['adaptedZoomButton']?.value;
        print('Zoom adapté');
      },
      style: buttonStyle,
    );
  }

  Widget zoomInButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return IconButton(
      icon: const Icon(Icons.zoom_in),
      tooltip: 'Zoom avant',
      onPressed: () {
        notifierMap['zoomInButton']?.value = !notifierMap['zoomInButton']?.value;
        print('Zoom avant');
      },
      style: buttonStyle,
    );
  }

  Widget zoomOutButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return IconButton(
      icon: const Icon(Icons.zoom_out),
      tooltip: 'Zoom arrière',
      onPressed: () {
        notifierMap['zoomOutButton']?.value = !notifierMap['zoomOutButton']?.value;
        print('Zoom arrière');
      },
      style: buttonStyle,
    );
  }

  Widget selectButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      ValueListenableBuilder<dynamic>(
        builder: (BuildContext context, dynamic value, Widget? child) {// print('valueSelected in main : $value');
          return
            IconButton(
              icon: const Icon(Icons.back_hand_rounded),
              tooltip: 'Sélectionner',
              onPressed: () {
                notifierMap['selectButton']?.value = !notifierMap['selectButton']?.value;
                if (notifierMap['selectButton']?.value) {
                  notifierMap['addNodeButton']?.value = false;
                  notifierMap['addRelationButton']?.value = false;
                }
                print('Sélectionner');
              },
              color: notifierMap['selectButton']?.value ? Colors.blue : Colors.black,
              highlightColor : Colors.blue.shade100,
            );
        },
        valueListenable: notifierMap['selectButton']!,
      );
  }

  Widget addNodeButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      ValueListenableBuilder<dynamic>(
        builder: (BuildContext context, dynamic value, Widget? child) {// print('valueSelected in main : $value');
          return
            IconButton(
              icon: const Icon(Icons.circle),
              tooltip: 'Ajouter un noeud',
              onPressed: () {
                //change style of button
                notifierMap['addNodeButton']?.value = !notifierMap['addNodeButton']?.value;
                if (notifierMap['addNodeButton']?.value) {
                  notifierMap['selectButton']?.value = false;
                  notifierMap['addRelationButton']?.value = false;
                }
                print('Ajouter un noeud');
              },
              color: notifierMap['addNodeButton']?.value ? Colors.blue : Colors.black,
              highlightColor : Colors.blue.shade100,
            );
        },
        valueListenable: notifierMap['addNodeButton']!,
      );
  }

  Widget addRelationButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      ValueListenableBuilder<dynamic>(
        builder: (BuildContext context, dynamic value, Widget? child) {// print('valueSelected in main : $value');
          return
            IconButton(
              icon: const Icon(Icons.arrow_right_alt),
              tooltip: 'Ajouter une relation',
              onPressed: () {
                notifierMap['addRelationButton']?.value = !notifierMap['addRelationButton']?.value;
                if (notifierMap['addRelationButton']?.value) {
                  notifierMap['selectButton']?.value = false;
                  notifierMap['addNodeButton']?.value = false;
                }
                print('Ajouter une relation');
              },
              color: notifierMap['addRelationButton']?.value ? Colors.blue : Colors.black,
              highlightColor : Colors.blue.shade100,
            );
        },
        valueListenable: notifierMap['addRelationButton']!,
      );
  }
}

class TopPalette extends Container {
  Map<String, ValueNotifier<dynamic>> notifierMap;
  File? jsonFile;
  TopPalette({super.key, required this.notifierMap});


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:  Border.all(color: Colors.black),
        ),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                width: 100,
                child: PaletteButton(buttonType: "new", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child:
                PaletteButton(buttonType: "open", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "download", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "undo", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "redo", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "adaptedZoom", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomIn", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomOut", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "select", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addNode", notifierMap: notifierMap),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addRelation", notifierMap: notifierMap),
              ),
              ValueListenableBuilder<dynamic>(
                builder: (BuildContext context, dynamic value, Widget? child) {
                  // This builder will only get called when isSelected.value is updated.
                  return Text('editor : $value');
                },
                valueListenable: notifierMap['activeEditingWidget']!,
                // The child parameter is most helpful if the child is
                // expensive to build and does not depend on the value from
                // the notifier.
              ),
            ],
          ),
        ),
      );

  }
}
