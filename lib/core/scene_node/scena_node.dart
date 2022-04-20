import 'dart:async';
import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_ship_landing/core/scene_node/scena_node_provider.dart';
import 'package:provider/provider.dart';

class SceneNodeManager {
  static SceneNodeManager instance = SceneNodeManager._();
  SceneNodeManager._() {}
  factory SceneNodeManager() {
    return instance;
  }

  Map<String, ScenaNodeProvider> _scensNode = Map<String, ScenaNodeProvider>();
  ScenaNodeProvider? getScenaNode(String name) {
    if (_scensNode.containsKey(name)) {
      return _scensNode[name];
    }
    return null;
  }

  bool addNode(ScenaNodeProvider node) {
    // if (_scensNode.containsKey(node.nodeName)) {
    //   return false;
    // }
    _scensNode[node.nodeName] = node;
    return true;
  }

  bool removeNode(ScenaNodeProvider node) {
    if (_scensNode.containsKey(node.nodeName)) {
      _scensNode.remove(node.nodeName);
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

class FlutterGameScena {
  final String name;
  final Widget scena;
  FlutterGameScena({required this.name, required this.scena});
  FlutterGameScena.empty()
      : name = '',
        scena = Container();
}

// class ScenaNode extends InheritedWidget with ChangeNotifier {
//   final StreamController<Widget?> _streamController =
//       StreamController<Widget?>.broadcast();
//   final Queue<FlutterGameScena> _scens = Queue<FlutterGameScena>();
//   FlutterGameScena? get currentScena => _scens.isNotEmpty ? _scens.last : null;
//   String? get current => _scens.isNotEmpty ? _scens.last.name : null;
//   final Widget child;
//   ScenaNode(this._nodeName, {required this.child}) : super(child: child) {
//     _streamController.onListen = () {
//       if (_scens.isNotEmpty) _streamController.add(_scens.last.scena);
//     };
//   }

//   String _nodeName;
//   String get nodeName => _nodeName;

//   Future<bool> addComponent(Component component, {String? scena}) async {
//     if (scena == null) {
//       if (currentScena?.scena is FlameGame) {
//         var g = (currentScena?.scena as FlameGame);
//         await g.add(component);
//         return true;
//       }
//     } else {
//       var f = _scens.firstWhere((element) => element.name == scena,
//           orElse: (() => FlutterGameScena.empty()));
//       if (f.name.isNotEmpty) {
//         if (currentScena?.scena is FlameGame) {
//           var g = (currentScena?.scena as FlameGame);
//           await g.add(component);
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   Future<bool> removeComponent(Component component, {String? scena}) async {
//     if (scena == null) {
//       if (currentScena?.scena is FlameGame) {
//         var g = (currentScena?.scena as FlameGame);
//         g.remove(component);
//         return true;
//       }
//     } else {
//       var f = _scens.firstWhere((element) => element.name == scena,
//           orElse: (() => FlutterGameScena.empty()));
//       if (f.name.isNotEmpty) {
//         if (currentScena?.scena is FlameGame) {
//           var g = (currentScena?.scena as FlameGame);
//           g.remove(component);
//           return true;
//         }
//       }
//     }
//     return false;
//   }

//   ///Push new scena in node
//   void push(String name, Widget scena) {
//     var s = FlutterGameScena(name: name, scena: scena);
//     _scens.add(s);
//     _streamController.add(scena);
//   }

//   ///pop scena from node
//   void pop() {
//     if (_scens.isNotEmpty) {
//       var s = _scens.removeLast();
//       if (_scens.isNotEmpty)
//         _streamController.add(_scens.last.scena);
//       else
//         _streamController.add(null);
//     }
//   }

//   static ScenaNode of(BuildContext context) {
//     final ScenaNode? result =
//         context.dependOnInheritedWidgetOfExactType<ScenaNode>();
//     assert(result != null, 'No ScenaNode found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(ScenaNode old) => false;
// }

///Это виджет встраивает узел сцены в дерево флаттера
class ScenaNodeWidget extends StatefulWidget {
  final String name;
  // late final List<Widget> children;
  final Function(ScenaNodeProvider node)? init;
  final List<Widget> Function(BuildContext context) build;
  // final ScenaNode _node;
  // late final Widget child;
  ScenaNodeWidget({
    Key? key,
    required this.name,
    List<Widget>? children,
    this.init,
    required this.build
  }) : super(key: key) {
    
  }

  ///load scena to Node
  // void load(String name, Widget widget) {
  //   var s = SceneNodeManager().getScenaNode(this.name);
  //   s?.push(name, widget);
  // }

  @override
  State<StatefulWidget> createState() => _ScenaNodeWidgetState(name);
}

class _ScenaNodeWidgetState extends State<ScenaNodeWidget> {
  final String name;
  // final List<Widget> children;
  late final ScenaNodeProvider scenaNode;
  bool isInit = false;
  _ScenaNodeWidgetState(this.name,) {}

  @override
  void dispose() {
    SceneNodeManager().removeNode(scenaNode);

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    scenaNode = ScenaNodeProvider(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ScenaNodeProvider>(create: (_) => scenaNode),
        ],
        builder: (c, child) {
          widget.init?.call(scenaNode);

          return StreamBuilder<Widget?>(
              stream: scenaNode.stream,
              builder: (context1, snapshot) {
                if (snapshot.hasData) {
                  return Stack(children: [snapshot.data!, ...widget.build(context1)]);
                }
                return Container();
              });
        });
  }
}
