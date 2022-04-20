import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';

class EarthGame extends FlameGame {
  final String name;
  final paralaxImage = [
    ParallaxImageData('background/Фон_день.png'),
    // ParallaxImageData('background/звезды.png'),
  ];
  // late final SpriteComponent earth;
  // Vector2 speedEarth = Vector2(0.5, 0);
  EarthGame({this.name = 'EarthGame'}) {}
  @override
  Future<void>? onLoad() async {
    //---- PARALLAX SECTION ----//
    final parallax = await loadParallaxComponent(
      paralaxImage,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    await add(parallax);

    return super.onLoad();
  }

  @override
  void update(double dt) {
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