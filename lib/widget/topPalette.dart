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
  final String buttonType;
  PaletteButton({super.key, required this.buttonType});

  @override
  PaletteButtonState createState() => new PaletteButtonState();
}

class PaletteButtonState extends State<PaletteButton> with ChangeNotifier {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('Good job!');

  final ValueNotifier<bool> isPressedNotifier = ValueNotifier(false);
  bool isPressed = false;

  void onPressedForStateButton(){
    setState(() {
      if (isPressed){isPressed = false;}
      else isPressed = true;
    });
    print('isPressed = $isPressed');
    notifyListeners();
  }


  @override
  Widget build(BuildContext context) {

    // test to get the right button
    switch (widget.buttonType) {
      case 'new':
        return newButton();
      case 'download':
        return downloadButton();
      case 'open':
        return openButton();
      case 'undo':
        return undoButton();
      case 'redo':
        return redoButton();
      case 'adaptedZoom':
        return adaptedZoomButton();
      case 'zoomIn':
        return zoomInButton();
      case 'zoomOut':
        return zoomOutButton();
      case 'select':
        return selectButton();
      case 'addNode':
        return addNodeButton();
      case 'addRelation':
        return addRelationButton();
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

  Widget newButton() {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Nouveau',
      onPressed: () {
        onPressedForStateButton();
        print('Nouveau');
      },
      style: buttonStyle,
    );
    // return
    //   ValueListenableBuilder<int>(
    //   builder: (BuildContext context, int value, Widget? child) {
    //     // This builder will only get called when the _counter
    //     // is updated.
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         Text('$value'),
    //         child!,
    //         FloatingActionButton(
    //           child: const Icon(Icons.plus_one),
    //           onPressed: () => _counter.value += 1,
    //         ),
    //       ],
    //     );
    //   },
    //   valueListenable: _counter,
    //   // The child parameter is most helpful if the child is
    //   // expensive to build and does not depend on the value from
    //   // the notifier.
    //   child: goodJob,
    // );
  }

  Widget openButton() {
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
      style: buttonStyle,
    );
  }

  Widget downloadButton() {

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Télécharger',
      onPressed: () {
        onPressedForStateButton();
        print('Télécharger');
      },
      style: buttonStyle,
    );
  }

  Widget undoButton() {
    return IconButton(
      icon: const Icon(Icons.undo),
      tooltip: 'Annuler',
      onPressed: () {
        onPressedForStateButton();
        print('Annuler');
      },
      style: buttonStyle,
    );
  }

  Widget redoButton() {
    return IconButton(
      icon: const Icon(Icons.redo),
      tooltip: 'Rétablir',
      onPressed: () {
        onPressedForStateButton();
        print('Rétablir');
      },
      style: buttonStyle,
    );
  }

  Widget adaptedZoomButton() {
    return IconButton(
      icon: const Icon(Icons.zoom_out_map),
      tooltip: 'Zoom adapté',
      onPressed: () {
        onPressedForStateButton();
        print('Zoom adapté');
      },
      style: buttonStyle,
    );
  }

  Widget zoomInButton() {
    return IconButton(
      icon: const Icon(Icons.zoom_in),
      tooltip: 'Zoom avant',
      onPressed: () {
        onPressedForStateButton();
        print('Zoom avant');
      },
      style: buttonStyle,
    );
  }

  Widget zoomOutButton() {
    return IconButton(
      icon: const Icon(Icons.zoom_out),
      tooltip: 'Zoom arrière',
      onPressed: () {
        onPressedForStateButton();
        print('Zoom arrière');
      },
      style: buttonStyle,
    );
  }

  Widget selectButton() {
    return IconButton(
      icon: const Icon(Icons.back_hand_rounded),
      tooltip: 'Sélectionner',
      onPressed: () {
        onPressedForStateButton();
        print('Sélectionner');
      },
      style: buttonStyle,
    );
  }

  Widget addNodeButton() {
    return IconButton(
      icon: const Icon(Icons.circle),
      tooltip: 'Ajouter un noeud',
      onPressed: () {
        onPressedForStateButton();
        print('Ajouter un noeud');
      },
      style: buttonStyle,
    );
  }

  Widget addRelationButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_right_alt),
      tooltip: 'Ajouter une relation',
      onPressed: () {
        onPressedForStateButton();
        print('Ajouter une relation');
      },
      style: buttonStyle,
    );
  }

}





class TopPalette extends Container {
  ValueNotifier<bool> isSelected;
  File? jsonFile;
  TopPalette({super.key, required this.isSelected});

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
              ValueListenableBuilder<bool>(
                builder: (BuildContext context, bool value, Widget? child) {
                  // This builder will only get called when isSelected.value is updated.
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('$value'),
                    ],
                  );
                },
                valueListenable: isSelected,
                // The child parameter is most helpful if the child is
                // expensive to build and does not depend on the value from
                // the notifier.
              ),
              Text(isSelected.value.toString()),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "new"),
              ),
              Container(
                //width 100
                width: 100,
                child:
                PaletteButton(buttonType: "open"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "download"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "undo"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "redo"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "adaptedZoom"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "zoomIn"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "zoomOut"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "select"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "addNode"),
              ),
              Container(
                //width 100
                width: 100,
                child: PaletteButton(buttonType: "addRelation"),
              ),
            ],
          ),
        ),
      );

  }
}
