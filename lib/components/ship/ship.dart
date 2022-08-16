import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_ship_landing/components/ship/components/body.dart';
import 'package:space_ship_landing/components/ship/components/driver.dart';
import 'package:space_ship_landing/models/for_component/size.dart';
import 'package:space_ship_landing/components/provider/flame_provider.dart';

class SpaceShip extends PositionComponent
    with HasGameRef, CollisionCallbacks
    implements SizeForChild, PositionForChild {
  SpaceShipBody body = SpaceShipBody();
  SpaceShipDriver ldriver = SpaceShipDriver();
  SpaceShipDriver rdriver = SpaceShipDriver();
  SpaceShipDriver mainDriver = SpaceShipDriver();
  @override
  Future<void>? onLoad() async {
    size = Vector2(50, 50 * 2.38);

    position.x = gameRef.size.x / 2;
    position.y = gameRef.size.y * 1 / 4;

    // position += Vector2(position.x, position.y)..rotate(0.5);

    await add(body);
    await body.add(ldriver);
    await body.add(rdriver);
    await body.add(mainDriver);
    anchor = Anchor.center;
    ldriver.anchor = Anchor.center;
    ldriver.size = size * 1;
    ldriver.position -= Vector2(100, 0);
    ldriver.transform.angleDegrees = 90;
    rdriver.anchor = Anchor.center;
    rdriver.size = size * 1;
    rdriver.position -= Vector2(-100 - size.x, 0);
    rdriver.transform.angleDegrees = -90;
    mainDriver.anchor = Anchor.center;
    mainDriver.size = size * 1;
    mainDriver.position -= Vector2(-size.x / 2, -size.y * 1.5);
    mainDriver.transform.angleDegrees = 0;

    // rdriver.size = size * 2;
    // rdriver.transform.angleDegrees = 270;
    await add(RectangleHitbox()..debugMode = true);
    // await add(TestComp());
    return super.onLoad();
  }
}
