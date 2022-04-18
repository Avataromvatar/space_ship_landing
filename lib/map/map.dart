import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BasicParallaxExample extends FlameGame {
  static const String description = '''
    Shows the simplest way to use a fullscreen `ParallaxComponent`.
  ''';

  final _imageNames = [
    // ParallaxImageData('background/sea/sea_background.png'),
    ParallaxImageData('background/sea/ship_background.png'),
    // ParallaxImageData('background/sea/ship_background.png'),
  ];

  @override
  Future<void> onLoad() async {
    var background = await loadSprite('background/sea/sea_background.png');
    // background.
    final com = SpriteComponent(sprite: background);
    com.scale = Vector2(2, 1.5);
    final parallax = await loadParallaxComponent(
      _imageNames,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    add(com);
    add(parallax);
  }
}
