import 'dart:async';
import 'dart:collection';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_ship_landing/core/scene_node/scena_node.dart';

class ScenaNodeProvider with ChangeNotifier {
  final StreamController<Widget?> _streamController =
      StreamController<Widget?>.broadcast();
  Stream<Widget?> get stream => _streamController.stream;
  final Queue<FlutterGameScena> _scens = Queue<FlutterGameScena>();
  FlutterGameScena? get currentScena => _scens.isNotEmpty ? _scens.last : null;
  String? get current => _scens.isNotEmpty ? _scens.last.name : null;
  String _nodeName;
  String get nodeName => _nodeName;

  ///
  ScenaNodeProvider(
    this._nodeName,
  ) {
    SceneNodeManager().addNode(this);

    _streamController.onListen = () {
      if (_scens.isNotEmpty) _streamController.add(_scens.last.scena);
    };
  }

  Future<bool> addComponent(Component component, {String? scena}) async {
    if (scena == null) {
      if (currentScena?.scena is GameWidget) {
        var g = (currentScena?.scena as GameWidget);
        await (g.game as FlameGame).add(component);
        return true;
      }
    } else {
      var f = _scens.firstWhere((element) => element.name == scena,
          orElse: (() => FlutterGameScena.empty()));
      if (f.name.isNotEmpty) {
        if (currentScena?.scena is GameWidget) {
          var g = (currentScena?.scena as GameWidget);
          await (g.game as FlameGame).add(component);
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> removeComponent(Component component, {String? scena}) async {
    if (scena == null) {
      if (currentScena?.scena is GameWidget) {
        var g = (currentScena?.scena as GameWidget);
        (g.game as FlameGame).remove(component);
        return true;
      }
    } else {
      var f = _scens.firstWhere((element) => element.name == scena,
          orElse: (() => FlutterGameScena.empty()));
      if (f.name.isNotEmpty) {
        if (currentScena?.scena is GameWidget) {
          var g = (currentScena?.scena as GameWidget);
          (g.game as FlameGame).remove(component);
          return true;
        }
      }
    }
    return false;
  }

  ///Push new scena in node
  void push(String name, Widget scena) {
    var s = FlutterGameScena(name: name, scena: scena);
    _scens.add(s);
    _streamController.add(scena);
  }

  ///pop scena from node
  void pop() {
    if (_scens.isNotEmpty) {
      var s = _scens.removeLast();
      if (_scens.isNotEmpty) {
        _streamController.add(_scens.last.scena);
      } else {
        _streamController.add(null);
      }
    }
  }
}
