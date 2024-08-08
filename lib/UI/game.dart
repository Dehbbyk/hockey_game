import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:hockey_game/components/background_border.dart';
import 'package:hockey_game/components/game_engine.dart';
import 'package:hockey_game/components/goal_post.dart';
import 'package:hockey_game/components/hockey_table.dart';
import 'package:hockey_game/components/paddle.dart';
import 'package:hockey_game/components/puck.dart';

import '../components/ai_paddle.dart';

class GlowHockeyGame extends FlameGame with HasCollisionDetection {
  late Sprite puckSprite;
  late Sprite paddleSprite;
  late Sprite paddle2Sprite;
  late Sprite tableSprite;
  late Sprite backgroundSprite;
  late GameEngine gameEngine;

  late AIPaddle player1Paddle;
  late Paddle player2Paddle;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    puckSprite = await loadSprite('Puck.png');
    paddleSprite = await loadSprite('PlayerRed.png');
    paddle2Sprite = await loadSprite('PlayerBlue.png');
    tableSprite = await loadSprite('Bg.png');
    backgroundSprite = await loadSprite('BgBorder.png');

    final backgroundBorder = BackgroundBorder(backgroundSprite);
    add(backgroundBorder);

    final hockeyTable = HockeyTable(sprite: tableSprite);
    add(hockeyTable);

    final puck = Puck(sprite: puckSprite);
    puck.position = hockeyTable.center;
    add(puck);

    final goalPost1 = GoalPost(
      player: 1,
      size: Vector2(50, 10),
      position: Vector2(size.x / 2 - 25, 0),
      color: const Color(0xFF000000), // Set goal post color to black
    );
    add(goalPost1);

    final goalPost2 = GoalPost(
      player: 2,
      size: Vector2(50, 10),
      position: Vector2(size.x / 2 - 25, size.y - 10),
      color: const Color(0xFF000000), // Set goal post color to black
    );
    add(goalPost2);

    gameEngine = GameEngine();
    add(gameEngine);

    player1Paddle = AIPaddle(
      minX: 0,
      maxX: size.x - 50,
      minY: 10,
      maxY: size.y / 2 - 10,
      position: Vector2(size.x / 2, size.y / 10),
      size: Vector2(50, 50),
      puck: puck,
      sprite: paddleSprite,
      aiSpeed: 200, //you can adjust this for difficulty
    );

    player2Paddle = Paddle(
      minX: 0,
      maxX: size.x - 50,
      minY: size.y / 2 + 10,
      maxY: size.y - 10,
      position: Vector2(size.x / 2, size.y - size.y / 10),
      size: Vector2(50, 50),
      puck: puck,
      sprite: paddle2Sprite,
    );

    add(player1Paddle);
    add(player2Paddle);
  }

  void resetPaddles() {
    player1Paddle.position = Vector2(size.x / 2, size.y / 10);
    player2Paddle.position = Vector2(size.x / 2, size.y - size.y / 10);
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
