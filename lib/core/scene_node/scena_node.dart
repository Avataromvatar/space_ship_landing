import 'dart:async';
import 'dart:collection';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SceneNodeManager {
  static SceneNodeManager instance = SceneNodeManager._();
  SceneNodeManager._() {}
  factory SceneNodeManager() {
    return instance;
  }

  Map<String, ScenaNode> _scensNode = Map<String, ScenaNode>();

  bool addNode(ScenaNode node) {
    if (_scensNode.containsKey(node.nodeName)) {
      return false;
    }
    _scensNode[node._nodeName] = node;
    return true;
  }

  bool removeNode(ScenaNode node) {
    if (_scensNode.containsKey(node.nodeName)) {
      _scensNode.remove(node._nodeName);
      return true;
    }

    return false;
  }
  // StreamController<Widget> _streamController = StreamController<Widget>();
  // Stream<Widget> get stream => _streamController.stream;
  // GameWidget<Scena>? _widget;
  // Scena? get root => _currentScena;
  // Scena? _currentScena;
  // Map<String, Scena> _scena = Map<String, Scena>();

  // Future<bool> goToScena(String scena) async {
  //   if (_scena.containsKey(scena)) {
  //     if (_currentScena != null) {
  //       if (_currentScena != _scena[scena]) {}
  //     }
  //   }

  //   // _widget = GameWidget(game: _currentScena!);
  // }
}

class GameScena {
  final String name;
  final Widget scena;
  GameScena({required this.name, required this.scena});
}

class ScenaNode extends InheritedWidget {
  final StreamController<Widget> _streamController = StreamController<Widget>();
  final Queue<GameScena> _scens = Queue<GameScena>();
  final Widget child;
  ScenaNode(this._nodeName, {required this.child}) : super(child: child) {}

  String _nodeName;
  String get nodeName => _nodeName;
  void push(String name, Widget scena) {
    var s = GameScena(name: name, scena: scena);
    _scens.add(s);
    _streamController.add(scena);
  }

  void pop() {
    if (_scens.isNotEmpty) {
      var s = _scens.removeLast();
      _streamController.add(s.scena);
    }
  }

  static ScenaNode of(BuildContext context) {
    final ScenaNode? result =
        context.dependOnInheritedWidgetOfExactType<ScenaNode>();
    assert(result != null, 'No ScenaNode found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ScenaNode old) => false;
}

class ScenaNodeWidget extends StatefulWidget {
  final String name;
  late final ScenaNode _node;
  late final Widget child;
  ScenaNodeWidget({Key? key, required this.name}) : super(key: key) {
    _node = ScenaNode(
      name,
      child: this,
    );

    child = StreamBuilder<Widget>(
        stream: _node._streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) return snapshot.data!;
          return Container();
        });
  }

  @override
  State<StatefulWidget> createState() => _ScenaNodeWidgetState();
}

class _ScenaNodeWidgetState extends State<ScenaNodeWidget> {
  @override
  void dispose() {
    SceneNodeManager().removeNode(widget._node);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    SceneNodeManager().addNode(widget._node);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._node;
    // ScenaNode(
    //   child: StreamBuilder<Widget>(
    //       stream: scenNode._streamController.stream,
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) return snapshot.data!;
    //         return Container();
    //       }),
    // );
  }
}
