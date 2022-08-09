import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_ship_landing/components/ship/components/body.dart';
import 'package:space_ship_landing/components/ship/components/driver.dart';
import 'package:space_ship_landing/models/for_component/size.dart';

class SpaceShip extends PositionComponent
    with HasGameRef, CollisionCallbacks
    implements SizeForChild, PositionForChild {
  SpaceShipBody body = SpaceShipBody();
  SpaceShipDriver ldriver = SpaceShipDriver();
  @override
  Future<void>? onLoad() async {
    size = Vector2(50, 50 * 2.38);

    position.x = gameRef.size.x / 2;
    position.y = gameRef.size.y * 1 / 4;

    // position += Vector2(position.x, position.y)..rotate(0.5);

    await add(body);
    await add(ldriver);
    await add(RectangleHitbox()..debugMode = true);
    // await add(TestComp());
    return super.onLoad();
  }
}
