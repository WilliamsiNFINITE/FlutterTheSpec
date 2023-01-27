import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../automate.dart';
import '../logic/export.dart';


class PaletteButton extends StatefulWidget{
  final ValueNotifier<bool> isPressedNotifier;
  final String buttonType;
  PaletteButton({super.key, required this.buttonType, required this.isPressedNotifier});

  @override
  PaletteButtonState createState() => new PaletteButtonState();
}

class PaletteButtonState extends State<PaletteButton> with ChangeNotifier {

  final ValueNotifier<bool> isPressedNotifier = ValueNotifier(false);
  bool isPressed = false;


  @override
  Widget build(BuildContext context) {

    // test to get the right button
    switch (widget.buttonType) {
      case 'new':
        return newButton(widget.isPressedNotifier);
      case 'download':
        return downloadButton(widget.isPressedNotifier);
      case 'open':
        return openButton(widget.isPressedNotifier);
      case 'undo':
        return undoButton(widget.isPressedNotifier);
      case 'redo':
        return redoButton(widget.isPressedNotifier);
      case 'adaptedZoom':
        return adaptedZoomButton(widget.isPressedNotifier);
      case 'zoomIn':
        return zoomInButton(widget.isPressedNotifier);
      case 'zoomOut':
        return zoomOutButton(widget.isPressedNotifier);
      case 'select':
        return selectButton(widget.isPressedNotifier);
      case 'addNode':
        return addNodeButton(widget.isPressedNotifier);
      case 'addRelation':
        return addRelationButton(widget.isPressedNotifier);
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

  Widget newButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Nouveau',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
//         isPressedNotifier.value = !isPressedNotifier.value;
        print('Nouveau :  $isPressedNotifier');
      },
      style: buttonStyle,
    );
  }

  Widget openButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.file_open),
      tooltip: 'Ouvrir',
      onPressed: () async {
        isPressedNotifier.value = !isPressedNotifier.value;
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
      style: buttonStyle,
    );
  }

  Widget downloadButton(ValueNotifier<bool> isPressedNotifier) {

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Télécharger',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Télécharger');
      },
      style: buttonStyle,
    );
  }

  Widget undoButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.undo),
      tooltip: 'Annuler',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Annuler');
      },
      style: buttonStyle,
    );
  }

  Widget redoButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.redo),
      tooltip: 'Rétablir',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Rétablir');
      },
      style: buttonStyle,
    );
  }

  Widget adaptedZoomButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.zoom_out_map),
      tooltip: 'Zoom adapté',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Zoom adapté');
      },
      style: buttonStyle,
    );
  }

  Widget zoomInButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.zoom_in),
      tooltip: 'Zoom avant',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Zoom avant');
      },
      style: buttonStyle,
    );
  }

  Widget zoomOutButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.zoom_out),
      tooltip: 'Zoom arrière',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Zoom arrière');
      },
      style: buttonStyle,
    );
  }

  Widget selectButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.back_hand_rounded),
      tooltip: 'Sélectionner',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Sélectionner');
      },
      style: buttonStyle,
    );
  }

  Widget addNodeButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.circle),
      tooltip: 'Ajouter un noeud',
      onPressed: () {
        //change style of button
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Ajouter un noeud');
      },
      style: buttonStyle,
    );
  }

  Widget addRelationButton(ValueNotifier<bool> isPressedNotifier) {
    return IconButton(
      icon: const Icon(Icons.arrow_right_alt),
      tooltip: 'Ajouter une relation',
      onPressed: () {
        isPressedNotifier.value = !isPressedNotifier.value;
        print('Ajouter une relation');
      },
      style: buttonStyle,
    );
  }

}


class TopPalette extends Container {
  // ValueNotifier<bool> isSelected;
  List<ValueNotifier<bool>> notifierList;
  File? jsonFile;
  TopPalette({super.key, required this.notifierList});


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
                width: 100,
                child: PaletteButton(buttonType: "new", isPressedNotifier: notifierList[0]),
              ),
              Container(
                width: 100,
                child:
                PaletteButton(buttonType: "open", isPressedNotifier: notifierList[1]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "download", isPressedNotifier: notifierList[2]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "undo", isPressedNotifier: notifierList[3]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "redo", isPressedNotifier: notifierList[4]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "adaptedZoom", isPressedNotifier: notifierList[5]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomIn", isPressedNotifier: notifierList[6]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomOut", isPressedNotifier: notifierList[7]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "select", isPressedNotifier: notifierList[8]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addNode", isPressedNotifier: notifierList[9]),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addRelation", isPressedNotifier: notifierList[10]),
              ),
              // ValueListenableBuilder<bool>(
              //   builder: (BuildContext context, bool value, Widget? child) {
              //     // This builder will only get called when isSelected.value is updated.
              //     return Text('$value');
              //   },
              //   valueListenable: notifierList[0],
              //   // The child parameter is most helpful if the child is
              //   // expensive to build and does not depend on the value from
              //   // the notifier.
              // ),
            ],
          ),
        ),
      );

  }
}
