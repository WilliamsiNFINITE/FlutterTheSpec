import 'graphSceneState.dart';
import 'package:flutter/material.dart';


class GraphScene extends StatefulWidget {
  List<ValueNotifier<dynamic>> notifierList;
  GraphScene({super.key, required this.notifierList});

  @override
  State<GraphScene> createState() => GraphSceneState();
}
