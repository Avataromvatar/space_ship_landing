import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:space_ship_landing/map/map.dart';
import 'package:space_ship_landing/routing/navigator_manager.dart';
import 'package:space_ship_landing/routing/route.dart';
import 'package:space_ship_landing/routing/route_path.dart';

void main() async {
  // final game = BasicParallaxExample();
  //FlameGame();
  // await game.add(BasicParallaxExample());
  // runApp(
  //   Material(child: LayoutBuilder(builder: ((context, constraints) {
  //   return GameWidget(game: game);
  // }))));
  runApp(MaterialApp(
      navigatorObservers: [
        NavigatorManager().getNavigatorObserver(eNavigators.root)
      ],
      navigatorKey: NavigatorManager().getNavigatorKey(eNavigators.root),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RoutePaths.start));
}
