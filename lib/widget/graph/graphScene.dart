import 'package:flutter/material.dart';
import 'graphSceneState.dart';


class GraphScene extends StatefulWidget {
  Map<String, ValueNotifier<dynamic>> notifierMap;
  GraphScene({super.key, required this.notifierMap});

  @override
  State<GraphScene> createState() => GraphSceneState();
}
