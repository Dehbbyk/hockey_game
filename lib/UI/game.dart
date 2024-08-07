import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import '../components/hockey_table.dart';
import '../components/paddle.dart';
import '../components/puck.dart';

class GlowHockeyGame extends FlameGame with HasCollisionDetection {
  late Sprite puckSprite;
  late Sprite paddleSprite;
  late Sprite paddle2Sprite;
  late Sprite tableSprite;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    puckSprite = await loadSprite('Puck.png');
    paddleSprite = await loadSprite('PlayerRed.png');
    paddle2Sprite = await loadSprite('PlayerBlue.png');
    tableSprite = await loadSprite('Bg.png');

    final hockeyTable = HockeyTable(sprite: tableSprite);
    add(hockeyTable);

    final puck = Puck(sprite: puckSprite);
    puck.position = hockeyTable.center;
    add(puck);

    add(
      Paddle(
        
      //  color: Colors.red.shade300,
        minX: 0, // Left edge of the play area
        maxX: size.x - 50, // Right edge of the play area
        minY: 10, // Top edge of the play area
        maxY: size.y / 2 - 10, // Bottom edge of the red play area
        position: Vector2(size.x / 2, size.y / 10),
        size: Vector2(100, 20),
        puck: puck, sprite: paddleSprite,
      ),
    );

    add(
      Paddle(
        //color: Colors.blue.shade300,
        minX: 0, // Left edge of the play area
        maxX: size.x - 50, // Right edge of the play area
        minY: size.y / 2 + 10, // Top edge of the blue play area
        maxY: size.y - 10, // Bottom edge of the play area
        position: Vector2(size.x / 2, size.y - size.y / 10),
        size: Vector2(100, 20),
        puck: puck, sprite: paddle2Sprite,
      ),
    );
  }
}



// class PauseButton extends SpriteComponent with HasGameRef<GlowHockeyGame> {
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     sprite = await Sprite.load('pause_button.png');
//     size = Vector2(50, 50);
//   }

//   @override
//   void onGameResize(Vector2 gameSize) {
//     super.onGameResize(gameSize);
//     // Positioning after the game size is known
//     position = Vector2(gameSize.x - 60, 10);
//   }
// }

// class ScoreDisplay extends TextComponent with HasGameRef<GlowHockeyGame> {
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     text = '0 - 0';
//     textRenderer = TextPaint(style: TextStyle(color: Colors.white, fontSize: 24));
//   }

//   @override
//   void onGameResize(Vector2 gameSize) {
//     super.onGameResize(gameSize);
//     position = Vector2(gameSize.x / 2 - textRenderer.textWidth(text) / 2, 10);
//   }

//   void updateText(String newText) {
//     text = newText;
//     final textWidth = textRenderer.measureTextWidth(text);
//     position.x = (gameRef.size.x - textWidth) / 2;  // Recenter text when it changes
// }
// }
