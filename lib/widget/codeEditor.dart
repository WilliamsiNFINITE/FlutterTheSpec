import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class CodeEditor extends StatefulWidget {
  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  CodeController? _codeController;

  @override
  void initState() {
    super.initState();
    final source = "// Place global declarations here.";
    // Instantiate the CodeController
    _codeController = CodeController(
      text: source,
      language: dart,
      // theme: monokaiSublimeTheme,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        CodeField(
          // padding: EdgeInsets.all(100), // padding for the line numbers
          // enabled: false, // text cannot be selected with the cursor
          // readOnly: true, // text can be selected with the cursor
          // textSelectionTheme: TextSelectionThemeData(
          //   cursorColor: Colors.blue,
          //   selectionColor: Colors.blue.shade200,
          //   selectionHandleColor: Colors.blue,
          // ),
          background: Colors.white,
          controller: _codeController!,
          lineNumberStyle: LineNumberStyle(
            textStyle: TextStyle(fontFamily: 'SourceCode', color: Colors.blue),
          ),  // LineNumberStyle
          textStyle: TextStyle(fontFamily: 'SourceCode', color: Colors.black),
          cursorColor: Colors.blue,
          isDense: true,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );

  }
}