import 'package:flutter/material.dart';
import 'package:flutter_the_spec/widget/relationPainter.dart';
import '../automate.dart';

class RelationWidget extends StatefulWidget {
  final Map<String, ValueNotifier<dynamic>> notifierMap;
  final Relation relation;

  RelationWidget(
      {super.key,
      required this.relation,
      required this.notifierMap});

  @override
  State<StatefulWidget> createState() => RelationWidgetState();
}

class RelationWidgetState extends State<RelationWidget> {
  late Map<String, ValueNotifier<dynamic>> notifierMap;
  late Relation relation;

  @override
  void initState() {
    super.initState();
    this.notifierMap = widget.notifierMap;
    this.relation = widget.relation;
  }

  @override
  Widget build(BuildContext context) {
    return Text('relation widget');
  }


}