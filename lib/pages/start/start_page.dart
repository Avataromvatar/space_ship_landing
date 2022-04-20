import 'dart:io';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:space_ship_landing/core/scene_node/scena_node.dart';
import 'package:space_ship_landing/core/scene_node/scena_node_provider.dart';
import 'package:space_ship_landing/map/map.dart';
import 'package:space_ship_landing/scena/main/earth.dart';
import 'package:space_ship_landing/scena/main/main_scena.dart';
import 'package:provider/provider.dart';

import 'package:flame/components.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isPush = false;
  bool isAddComponent = false;
  SpriteComponent? earth;
  ScenaNodeProvider? providerScena;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: size.width,
          height: size.height,
          child: ScenaNodeWidget(
            name: 'root',
            build: (context) {
              return [
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text('Hello WORLD!!!'),
                    onPressed: () {
                      print('Hello programm!');
                      if (!isPush) {
                        isPush = true;
                        var prov = context.read<ScenaNodeProvider>();
                        prov.push('earth', GameWidget(game: EarthGame()));
                      } else {
                        var prov = context.read<ScenaNodeProvider>();
                        prov.pop();
                        isPush = false;
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    child: Text('Add or remove component'),
                    onPressed: () async {
                      if (!isAddComponent) {
                        isAddComponent = true;
                        var prov = context.read<ScenaNodeProvider>();
                        earth = SpriteComponent(
                            sprite: await Sprite.load(
                                'background/планета_Земля.png'));
                        earth?.position = Vector2(0, 0);
                        prov.addComponent(earth!);
                      } else {
                        var prov = context.read<ScenaNodeProvider>();
                        prov.removeComponent(earth!);
                        isAddComponent = false;
                      }
                    },
                  ),
                ),
              ];
            },
            init: (node) {
              providerScena = node;
              providerScena?.push('parallax', GameWidget(game: MainGame()));
            },
          )
          // Stack(children: [
          //   ScenaNodeWidget(name: 'root')
          //     ..load('parallax', GameWidget(game: BasicParallaxExample())),
          //   Align(
          //     alignment: Alignment.topCenter,
          //     child: Text('ПРИВЕТ !!'),
          //   ),
          // ]),
          ),
    );
  }
}
