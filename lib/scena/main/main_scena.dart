import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_ship_landing/components/ship/ship.dart';
import 'package:space_ship_landing/sprites/rocket.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:space_ship_landing/components/platform/paltform.dart';

class MainGame extends Forge2DGame with HasDraggables, HasCollisionDetection {
  final String name;
  final paralaxImage = [
    ParallaxImageData('background/фон.png'),
    ParallaxImageData('background/звезды_1.png'),
  ];
  late final SpriteComponent earth;
  late final SpriteComponent moon;
  late final SpaceShip spaceShip; //
  late final Rocket rocket; //

  late final JoystickComponent joystick;
  late final PlatformComponent platform;
  Vector2 speedEarth = Vector2(1, 0);
  MainGame({this.name = 'MainScena'}) : super(gravity: Vector2(0, 0)) {}

  @override
  Future<void>? onLoad() async {
    print('onLoad');
    camera.zoom = 1;
    //---- PARALLAX SECTION ----//
    final parallax = await loadParallaxComponent(
      paralaxImage,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    await add(parallax);
    //---- PLANET SECTION ----//
    earth =
        SpriteComponent(sprite: await loadSprite('background/Earth_big.png'));
    moon = SpriteComponent(sprite: await loadSprite('background/moon.png'));
    platform = PlatformComponent();
    // platform =
    //     SpriteComponent(sprite: await loadSprite('background/платформа.png'));
    await add(earth);
    await add(moon);
    await add(platform);

    var p = earth.position;
    platform.size = platform.sprite!.srcSize;
    platform.scale = Vector2(4, 4);
    platform.position = Vector2(size.x * 0.5, size.y * 0.8);
    // earth.scale = Vector2(0.5, 0.5);
    p.x = size.x * 0.5;
    p.y = size.y * 0.5;
    camera.zoom = 0.5;
    var l = camera.viewport.effectiveSize;
    var c = canvasSize;
    // moon.position.x = (-moon.size.x / 2 + camera.gameSize.x / 2);
    // moon.position.y = (camera.gameSize.y - moon.size.y);
    moon.scale = Vector2(camera.gameSize.x / moon.sprite!.srcSize.x, 1);
    moon.position = Vector2(
        (-(moon.size.x * moon.scale.x) / 2 + camera.gameSize.x / 2),
        camera.gameSize.y - moon.size.y);

    earth.setOpacity(1);

    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    rocket = Rocket(joystick);
    spaceShip = SpaceShip();
    await add(spaceShip);
    // await add(rocket);
    await add(joystick);

    return super.onLoad();
  }

  double rrrr = 0;
  @override
  void update(double dt) {
    moveEarth(dt);
    // var p = camera.position;

    // rrrr += dt * 20;
    // camera.moveTo(Vector2(rrrr, 0));

    super.update(dt);
  }

  void moveEarth(double dt) {
    speedEarth.rotate(dt * 0.1);
    // speed.rotate(dt * 60);
    // spaceShip.position += speedEarth;
    earth.position += speedEarth;
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