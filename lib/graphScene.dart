import 'automate.dart';
import 'graphSceneState.dart';
import 'package:flutter/material.dart';


class GraphScene extends StatefulWidget {
  const GraphScene({super.key});

  @override
  State<GraphScene> createState() => GraphSceneState();

  Automate getAutomate() {
    return GraphSceneState().getAutomate();
  }

}
