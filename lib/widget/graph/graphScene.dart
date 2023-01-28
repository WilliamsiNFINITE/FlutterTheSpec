import 'package:flutter/material.dart';
import 'graphSceneState.dart';


class GraphScene extends StatefulWidget {
  List<ValueNotifier<dynamic>> notifierList;
  GraphScene({super.key, required this.notifierList});

  @override
  State<GraphScene> createState() => GraphSceneState();
}
