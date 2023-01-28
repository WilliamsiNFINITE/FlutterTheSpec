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
  final List<ValueNotifier<dynamic>> notifierList;
  final String buttonType;
  PaletteButton({super.key, required this.buttonType, required this.notifierList});

  @override
  PaletteButtonState createState() => new PaletteButtonState();
}

class PaletteButtonState extends State<PaletteButton> with ChangeNotifier {

  late List<ValueNotifier<dynamic>> notifierList;
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
        return newButton(widget.notifierList);
      case 'download':
        return downloadButton(widget.notifierList);
      case 'open':
        return openButton(widget.notifierList);
      case 'undo':
        return undoButton(widget.notifierList);
      case 'redo':
        return redoButton(widget.notifierList);
      case 'adaptedZoom':
        return adaptedZoomButton(widget.notifierList);
      case 'zoomIn':
        return zoomInButton(widget.notifierList);
      case 'zoomOut':
        return zoomOutButton(widget.notifierList);
      case 'select':
        return selectButton(widget.notifierList);
      case 'addNode':
        return addNodeButton(widget.notifierList);
      case 'addRelation':
        return addRelationButton(widget.notifierList);
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

  Widget newButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Nouveau',
      onPressed: () {
        notifierList[0].value = !notifierList[0].value;
//         notifierList[.value = !notifierList[.value;
        print('Nouveau :  $notifierList[');
      },
      style: buttonStyle,
    );
  }

  Widget openButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.file_open),
      tooltip: 'Ouvrir',
      onPressed: () async {
        notifierList[1].value = !notifierList[1].value;
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );
        if(result != null){
          var bytesFile = result.files.single.bytes;
          var jsonText = String.fromCharCodes(bytesFile!);
          Automate automate = Automate.fromJson(jsonDecode(jsonText));

          notifierList[11].value = automate;

          print(notifierList[11].value.toJson());
          print('Import réussi');
        }
        else{
          print('Import échoué');
        }
      },
      style: buttonStyle,
    );
  }

  Widget downloadButton(List<ValueNotifier<dynamic>> notifierList) {

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Télécharger',
      onPressed: () {
        notifierList[2].value = !notifierList[2].value;
        exportAutomate(notifierList[11].value);
        print('Télécharger');
      },
      style: buttonStyle,
    );
  }

  Widget undoButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.undo),
      tooltip: 'Annuler',
      onPressed: () {
        notifierList[3].value = !notifierList[3].value;
        print('Annuler');
      },
      style: buttonStyle,
    );
  }

  Widget redoButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.redo),
      tooltip: 'Rétablir',
      onPressed: () {
        notifierList[4].value = !notifierList[4].value;
        print('Rétablir');
      },
      style: buttonStyle,
    );
  }

  Widget adaptedZoomButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.zoom_out_map),
      tooltip: 'Zoom adapté',
      onPressed: () {
        notifierList[5].value = !notifierList[5].value;
        print('Zoom adapté');
      },
      style: buttonStyle,
    );
  }

  Widget zoomInButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.zoom_in),
      tooltip: 'Zoom avant',
      onPressed: () {
        notifierList[6].value = !notifierList[6].value;
        print('Zoom avant');
      },
      style: buttonStyle,
    );
  }

  Widget zoomOutButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.zoom_out),
      tooltip: 'Zoom arrière',
      onPressed: () {
        notifierList[7].value = !notifierList[7].value;
        print('Zoom arrière');
      },
      style: buttonStyle,
    );
  }

  Widget selectButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.back_hand_rounded),
      tooltip: 'Sélectionner',
      onPressed: () {
        notifierList[8].value = !notifierList[8].value;
        print('Sélectionner');
      },
      style: buttonStyle,
    );
  }

  Widget addNodeButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.circle),
      tooltip: 'Ajouter un noeud',
      onPressed: () {
        //change style of button
        notifierList[9].value = !notifierList[9].value;
        print('Ajouter un noeud');
      },
      style: buttonStyle,
    );
  }

  Widget addRelationButton(List<ValueNotifier<dynamic>> notifierList) {
    return IconButton(
      icon: const Icon(Icons.arrow_right_alt),
      tooltip: 'Ajouter une relation',
      onPressed: () {
        notifierList[10].value = !notifierList[10].value;
        print('Ajouter une relation');
      },
      style: buttonStyle,
    );
  }

}

class TopPalette extends Container {
  List<ValueNotifier<dynamic>> notifierList;
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
                child: PaletteButton(buttonType: "new", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child:
                PaletteButton(buttonType: "open", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "download", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "undo", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "redo", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "adaptedZoom", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomIn", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "zoomOut", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "select", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addNode", notifierList: notifierList),
              ),
              Container(
                width: 100,
                child: PaletteButton(buttonType: "addRelation", notifierList: notifierList),
              ),
              // ValueListenableBuilder<bool>(
              //   builder: (BuildContext context, bool value, Widget? child) {
              //     // This builder will only get called when isSelected.value is updated.
              //     return Text('$value');
              //   },
              //   valueListenable: notifierList,
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
