import 'dart:io';
import 'package:flutter/material.dart';
import '../logic/utils.dart';


class PaletteButton extends StatefulWidget{
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final String buttonType;
  const PaletteButton({super.key, required this.buttonType, required this.notifierMap});

  @override
  PaletteButtonState createState() => PaletteButtonState();
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
          newAutomaton(notifierMap);
        },
        highlightColor : Colors.blue.shade100,
      );
  }

  Widget openButton(Map<String, ValueNotifier<dynamic>> notifierMap) {
    return
      IconButton(
      icon: const Icon(Icons.file_open),
      tooltip: 'Ouvrir',
      onPressed: (){
        importAutomaton(notifierMap);
      },
      highlightColor : Colors.blue.shade100,
    );
  }

  Widget downloadButton(Map<String, ValueNotifier<dynamic>> notifierMap) {

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Télécharger',
      onPressed: () {
        exportAutomaton(notifierMap);
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
                  // on désactive les autres boutons
                  notifierMap['selectButton']?.value = false;
                  notifierMap['addNodeButton']?.value = false;

                  // // on désactive le mode de sélection (not working)
                  // for (var node in notifierMap['automata']!.value.nodes) {
                  //   if (notifierMap['selectedWidget']!.value[node.name] ==
                  //       true) {
                  //     notifierMap['selectedWidget']!.value[node.name] = false;
                  //   }
                  // }
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
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "new", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child:
                PaletteButton(buttonType: "open", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "download", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "undo", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "redo", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "adaptedZoom", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "zoomIn", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "zoomOut", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "select", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "addNode", notifierMap: notifierMap),
              ),
              SizedBox(
                width: 100,
                child: PaletteButton(buttonType: "addRelation", notifierMap: notifierMap),
              ),
            ],
          ),
        ),
      );

  }
}
