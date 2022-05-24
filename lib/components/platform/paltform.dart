import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class PlatformComponent extends SpriteComponent /*with CollisionCallbacks*/ {
  PlatformComponent();
  late RectangleHitbox hitBox;
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    print('onCollision');
    if (other is RectangleHitbox) {
      //...
    }
    // else if (other is YourOtherComponent) {
    //   //...
    // }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    print('onCollisionEnd');
    if (other is ScreenHitbox) {
      //...
    }
    // else if (other is YourOtherComponent) {
    //   //...
    // }
  }

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('background/платформа.png');
    hitBox = RectangleHitbox();
    hitBox.debugMode = true;
    hitBox.debugColor = Colors.red;
    add(hitBox);
    // TODO: implement onLoad
    super.onLoad();
    return;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
