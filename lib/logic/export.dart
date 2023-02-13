import 'dart:convert';
import 'dart:convert' show json;
import 'package:flutter_the_spec/automaton.dart';
import 'dart:html' as webFile;

void exportAutomate(Automaton automate) {
    try{
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