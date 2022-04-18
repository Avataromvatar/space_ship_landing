import 'package:flutter/material.dart';

class CustomNavigatorObserver with NavigatorObserver {
  String name;
  List<String> _pathsList = List<String>.empty(growable: true);
  String get path => _pathsList.reduce((value, element) => '$value$element');
  String get fullClearPath => _pathsList
      .reduce((value, element) => '$value$element')
      .replaceAll('/null', '');

  String get current => _pathsList.last;
  String? get last => _pathsList.isEmpty
      ? null
      : _pathsList.length == 1
          ? null
          : _pathsList[_pathsList.length - 2];
  CustomNavigatorObserver(
    this.name,
  ) {}

  String getFullClearPath() {
    String str = fullClearPath;
    int index = str.lastIndexOf('/');
    return str.substring(index);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print(
        '$name: didPop: ${previousRoute?.settings.name ?? 'null'} <- ${route.settings.name} pop:${_pathsList.isNotEmpty ? _pathsList.removeLast() : ''}');

    // TODO: implement didPop
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        '$name: didPush: ${previousRoute?.settings.name ?? 'null'} -> ${route.settings.name}');
    _pathsList.add(route.settings.name ?? '/null');
    // TODO: implement didPush
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print(
        '$name: didRemove: ${previousRoute?.settings.name ?? 'null'} <- ${route.settings.name}');
    // TODO: implement didRemove
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print(
        '$name: didReplace: ${oldRoute?.settings.name ?? 'null'} -> ${newRoute?.settings.name ?? 'null'}');
    // TODO: implement didReplace
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    print(
        '$name: didStartUserGesture: ${previousRoute?.settings.name ?? 'null'} -> ${route.settings.name}');
    // TODO: implement didStartUserGesture
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    print('$name: didStopUserGesture');
    // TODO: implement didStopUserGesture
    super.didStopUserGesture();
  }
}
