import 'dart:convert';
import 'dart:convert' show json;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_the_spec/automaton.dart';
import 'dart:html' as webFile;

void exportAutomaton(notifierMap) {
    try{
    notifierMap['downloadButton']?.value = !notifierMap['downloadButton']?.value;
    Automaton automate = notifierMap['automata']?.value;
    List jsonList = [];
    jsonList.add(json.encode(automate.toJson()));
    var blob = webFile.Blob(jsonList, 'text/plain', 'native');
    var anchorElement = webFile.AnchorElement(
      href: webFile.Url.createObjectUrlFromBlob(blob).toString(),
    )
      ..setAttribute("download", "automate.json")
      ..click();

    print('Saved data successfully!');
  } catch (e) {
    print('Error: $e');
  }

}

void importAutomaton(notifierMap) async {

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

}

void newAutomaton(notifierMap) {
  notifierMap['newButton']?.value = !notifierMap['newButton']?.value;
  notifierMap['automata']?.value = Automaton(nodes: [], relations: []);
}