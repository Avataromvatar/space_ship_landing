import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Rocket extends SpriteComponent with HasGameRef, CollisionCallbacks{
  double maxSpeed = 300.0;
  double gravitationYSpeed = 0.0;
  double gravitationXSpeed = 0.0;

  static double rocketWidth = 50.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();

  final JoystickComponent joystick;

  Rocket(this.joystick) : super(size: Vector2(rocketWidth, rocketWidth*2.38), anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('object/rocket.png');
    position.x = gameRef.size.x/2;
    position.y = gameRef.size.y*1/4;
    add(RectangleHitbox()..debugMode = true);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
      _lastSize.setFrom(size);
      _lastTransform.setFrom(transform);
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }

    position.y += setGravitationYSpeed(dt);
    position.x -= gravitationXSpeed*dt;

    super.update(dt);
  }

  setGravitationYSpeed(double dt) {
    gravitationYSpeed = (gravitationYSpeed + 1.1 * dt)/10;
    return gravitationYSpeed;
  }



  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    transform.setFrom(_lastTransform);
    size.setFrom(_lastSize);
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent __) {
    super.onCollisionEnd(__);
  }


}