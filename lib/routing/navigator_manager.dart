import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:space_ship_landing/routing/custom_navigator_observer.dart';
import 'package:space_ship_landing/routing/route.dart';

enum eNavigators {
  root,
}

class NavigatorHandler {
  late CustomNavigatorObserver observer;
  late Navigator navigator;
  GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get key => _key;
  // late GlobalKey<NavigatorState> _navigatorState;
  // Navigator? get navigator => _navigatorState.currentState?.widget;
  final String name;
  String get path => observer.path;
  String get current => observer.current;
  String? get last => observer.last;
  NavigatorHandler(this.name, String initalRoute,
      Route Function(RouteSettings settings) generateRoute,
      {List<Route<dynamic>> Function(NavigatorState, String)?
          onGenerateInitialRoutes}) {
    observer = CustomNavigatorObserver(name);
    // _navigatorState = GlobalKey<NavigatorState>();
    navigator = Navigator(
      key: _key,
      onGenerateRoute: generateRoute,
      initialRoute: initalRoute,
      onGenerateInitialRoutes:
          onGenerateInitialRoutes ?? Navigator.defaultGenerateInitialRoutes,
    );

    // navigator.createState()
  }
}

class NavigatorManager {
  static NavigatorManager _instance = NavigatorManager._();
  // GlobalKey<NavigatorState> _globalNavState = GlobalKey<NavigatorState>();
  // GlobalKey<NavigatorState> get navigatorState => _globalNavState;
  // NavigatorState? get navigator => _globalNavState.currentState;
  Map<eNavigators, NavigatorHandler> _navigators =
      Map<eNavigators, NavigatorHandler>();
  // CustomNavigatorObserver _rootObserver =
  //     CustomNavigatorObserver(eNavigators.root.name);
  // CustomNavigatorObserver get rootObserver => _rootObserver;

  NavigatorManager._() {
    _navigators[eNavigators.root] =
        NavigatorHandler(eNavigators.root.name, '/', AppRouter.onGenerateRoute);
  }
  factory NavigatorManager() {
    return _instance;
  }

  CustomNavigatorObserver getNavigatorObserver(eNavigators type) {
    // if (type == eNavigators.root) return navigator!.widget;
    return _navigators[type]!.observer;
  }

  NavigatorState? getNavigatorState(eNavigators type) {
    // if (type == eNavigators.root) return navigator!.widget;
    return _navigators[type]!.key.currentState;
  }

  GlobalKey<NavigatorState> getNavigatorKey(eNavigators type) {
    // if (type == eNavigators.root) return navigator!.widget;
    return _navigators[type]!.key;
  }

  Navigator getNavigator(eNavigators type) {
    // if (type == eNavigators.root) return navigator!.widget;
    return _navigators[type]!.navigator;
  }

  String getFullPath(eNavigators type) {
    // if (type == eNavigators.root) return _rootObserver.path;
    return _navigators[type]!.path;
  }

  ///clear path not have '/null'
  String getFullClearPath(eNavigators type) {
    // if (type == eNavigators.root) return _rootObserver.path;
    return _navigators[type]!.observer.fullClearPath;
  }

  ///clear path not have '/null'
  String getLastClearPath(eNavigators type) {
    // if (type == eNavigators.root) return _rootObserver.path;
    return _navigators[type]!.observer.getFullClearPath();
  }

  String getCurrentPage(eNavigators type) {
    // if (type == eNavigators.root) return _rootObserver.current;
    return _navigators[type]!.current;
  }

  String? getLastPage(eNavigators type) {
    // if (type == eNavigators.root) return _rootObserver.last;
    return _navigators[type]!.last;
  }
}
