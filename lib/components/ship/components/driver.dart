import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_ship_landing/components/provider/flame_provider.dart';
import 'package:space_ship_landing/core/interface/driver/driver.dart';
import 'package:space_ship_landing/models/for_component/size.dart';

class SpaceShipDriver extends SpriteComponent
    with HasGameRef
    implements Driver {
  StreamController<double> _forses = StreamController<double>.broadcast();
  double _lastForce = 0.0;
  double _lastFuel = 0.0;
  StreamSubscription? _subscription;
  // SpaceShipDriver
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('object/rocket.png');
    // size = (searchInParent<SizeForChild>()?.size ?? Vector2.zero()) * 2;
    // transform.angleDegrees = 90;
    // position.x = gameRef.size.x / 2;
    // position.y = gameRef.size.y * 1 / 4;
    await add(RectangleHitbox()..debugMode = true);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }

  //------- -------//
  bool _isWork = false;
  bool get isWork => _isWork;
  Stream<double> get forceStream => _forses.stream;
  double get force => _lastForce;
  Future<void> addFuelStream(Stream<double> fuelStream) async {
    if (_subscription != null) await _subscription!.cancel();
    _subscription = fuelStream.listen((event) {
      _calculate(event);
    });
  }

  Future<void> stop() async {
    _isWork = false;
  }

  void start() {
    _isWork = true;
  }

  void _calculate(double value) {
    if (_isWork) {
      _forses.add(value);
    }
  }
}
