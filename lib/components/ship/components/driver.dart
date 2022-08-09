import 'package:flame/components.dart';
import 'package:space_ship_landing/components/provider/flame_provider.dart';
import 'package:space_ship_landing/models/for_component/size.dart';

class SpaceShipDriver extends SpriteComponent with HasGameRef {
  // SpaceShipDriver
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('object/rocket.png');
    size = (searchInParent<SizeForChild>()?.size ?? Vector2.zero()) * 2;
    transform.angleDegrees = 90;
    // position.x = gameRef.size.x / 2;
    // position.y = gameRef.size.y * 1 / 4;
    return super.onLoad();
  }
}
