import 'dart:math' as Math;

import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';

class EarthGame extends FlameGame {
  final String name;
  final paralaxImage = [
    ParallaxImageData('background/background_sky.png'),
    ParallaxImageData('background/background_land.png'),
    // ParallaxImageData('background/звезды.png'),
  ];
  // late final SpriteComponent earth;
  // Vector2 speedEarth = Vector2(0.5, 0);
  List<SpriteComponent> terrain = [];
  late SpriteComponent sky;
  EarthGame({this.name = 'EarthGame'}) {}
  @override
  Future<void>? onLoad() async {
    //---- PARALLAX SECTION ----//
    final parallax = await loadParallaxComponent(
      paralaxImage,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      // scale: Vector2(
    );

    // var s = Vector2(
    //     parallax.parallax!.layers.first.parallaxRenderer.image.width * 1.0,
    //     parallax.parallax!.layers.first.parallaxRenderer.image.height * 1.0);
    // var scanvas = size;
    // parallax.scaledSize = Vector2(scanvas.x / s.x, scanvas.y / s.y);
    var scanvas = size;
    // await add(parallax);

    // parallax.scale = Vector2(1, (scanvas.y / parallax.size.y) * 0.5);
    // parallax.position = Vector2(parallax.position.x, scanvas.y / 2);
    terrain.add(SpriteComponent(
        sprite: await loadSprite('background/background_land.png')));
    terrain.add(SpriteComponent(
        sprite: await loadSprite('background/background_land.png')));
    terrain.add(SpriteComponent(
        sprite: await loadSprite('background/background_land.png')));
    sky = SpriteComponent(
        sprite: await loadSprite('background/background_sky.png'));

    // terrain.scale = Vector2(1, (scanvas.y / terrain.size.y) * 0.5);
    // terrain.position = Vector2(terrain.position.x, scanvas.y / 2);
    await add(terrain[0]);
    // terrain[0].position -= Vector2(terrain[0].width / 2, 0);
    await add(terrain[1]);
    await add(terrain[2]);
    terrain[0].position =
        terrain[0].position = Vector2(0, terrain[0].height / 2);
    terrain[1].position = terrain[0].position + Vector2(terrain[0].width, 0);
    terrain[2].position = terrain[1].position + Vector2(terrain[0].width, 0);
    terrain[0].scale = Vector2(1, 0.5);
    terrain[1].scale = Vector2(1, 0.5);
    terrain[2].scale = Vector2(1, 0.5);

    // terrain.scale = Vector2(1, 1);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // terrain[0].position = terrain[0].position - Vector2(100 * dt, 0);
    // if (terrain[0].position.x.abs() > terrain[0].width) {
    //   terrain[0].position = terrain[0].position + Vector2(terrain[0].width, 0);
    // }
    for (var i = 0; i < terrain.length; i++) {
      terrain[i].position = terrain[i].position - Vector2(400 * dt, 0);

      if (terrain[i].position.x < terrain[i].width * -1) {
        terrain[i].position =
            terrain[i].position + Vector2(terrain[0].width * 2, 0);
      }
    }

    super.update(dt);
  }
}

//  static const String description = '''
//     Shows the simplest way to use a fullscreen `ParallaxComponent`.
//   ''';

//   final _imageNames = [
//     // ParallaxImageData('background/sea/sea_background.png'),
//     ParallaxImageData('background/sea/ship_background.png'),
//     // ParallaxImageData('background/sea/ship_background.png'),
//   ];

//   @override
//   Future<void> onLoad() async {
//     var background = await loadSprite('background/sea/sea_background.png');
//     // background.
//     final com = SpriteComponent(sprite: background);
//     com.scale = Vector2(2, 1.5);
//     final parallax = await loadParallaxComponent(
//       _imageNames,
//       baseVelocity: Vector2(20, 0),
//       velocityMultiplierDelta: Vector2(1.8, 1.0),
//     );
//     add(com);
//     add(parallax);
//   }