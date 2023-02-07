import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_the_spec/automate.dart';
import 'package:flutter_the_spec/widget/topPalette.dart';

void main() {


    group('Buttons', () {
        setUp (() {

            Map<String, ValueNotifier<dynamic>> notifierMap = {};

            notifierMap['newButton'] = ValueNotifier<bool>(false);
            notifierMap['openButton'] = ValueNotifier<bool>(false);
            notifierMap['downloadButton'] = ValueNotifier<bool>(false);
            notifierMap['undoButton'] = ValueNotifier<bool>(false);
            notifierMap['redoButton'] = ValueNotifier<bool>(false);
            notifierMap['adaptedZoomButton'] = ValueNotifier<bool>(false);
            notifierMap['zoomInButton'] = ValueNotifier<bool>(false);
            notifierMap['zoomOutButton'] = ValueNotifier<bool>(false);
            notifierMap['selectButton'] = ValueNotifier<bool>(false);
            notifierMap['addNodeButton'] = ValueNotifier<bool>(false);
            notifierMap['addRelationButton'] = ValueNotifier<bool>(false);

            // Automata
            notifierMap['automata'] = ValueNotifier<dynamic>(Automate(nodes: [], relations: []));

            // Active editing widget
            notifierMap['activeEditingWidget'] = ValueNotifier<bool>(true);
            TopPalette topPalette = TopPalette(notifierMap: notifierMap);
        });

        test('new button should change the value of the right notifier (0)', (){

        });
        test('open button should change the value of the right notifier (1)', (){

        });
        test('save button should change the value of the right notifier (2)', (){

        });
        test('undo button should change the value of the right notifier (3)', (){

        });
        test('redo button should change the value of the right notifier (4)', (){

        });
        test('adapted zoom button should change the value of the right notifier (5)', (){

        });
        test('zoom in button should change the value of the right notifier (6)', (){

        });
        test('zoom out button should change the value of the right notifier (7)', (){

        });
        test('Select button should change the value of the right notifier (8)', (){
            // Test on the notifier only. Color comes with the notifier
        });
        test('Add node button should change the value of the right notifier (9)', (){

        });
        test('Add relation button should change the value of the right notifier (10)', (){

        });
    });
}

