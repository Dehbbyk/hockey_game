import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/components/background_border.dart';
import 'package:hockey_game/components/game_engine.dart';
import 'package:hockey_game/components/goal_post.dart';
import 'package:hockey_game/components/hockey_table.dart';
import 'package:hockey_game/components/paddle.dart';
import 'package:hockey_game/components/puck.dart';
import '../components/ai_paddle.dart';
import '../components/score_display.dart';

class GlowHockeyGame extends FlameGame with HasCollisionDetection {
  final String mode;

  GlowHockeyGame({required this.mode});

  late Sprite puckSprite;
  late Sprite paddleSprite;
  late Sprite paddle2Sprite;
  late Sprite tableSprite;
  late Sprite backgroundSprite;
  late Sprite collisionEffectSprite;
  late GameEngine gameEngine;
  late ScoreDisplay scoreDisplay;

  late Paddle player1Paddle;
  late Paddle player2Paddle;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    puckSprite = await loadSprite('Puck.png');
    paddleSprite = await loadSprite('PlayerRed.png');
    paddle2Sprite = await loadSprite('PlayerBlue.png');
    tableSprite = await loadSprite('Bg.png');
    backgroundSprite = await loadSprite('BgBorder.png');
    collisionEffectSprite = await loadSprite('collision_effect.jpg');

    FlameAudio.audioCache.loadAll(['collision_sound.mp3', 'goal_sound.mp3']);

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
      color: const Color(0xFF000000),
    );
    add(goalPost2);

    gameEngine = GameEngine();
    gameEngine.onScoreChanged = (int player1Score, int player2Score) {
      scoreDisplay.updateText(player1Score, player2Score);
    };
    add(gameEngine);

    scoreDisplay = ScoreDisplay();
    add(scoreDisplay);

    if (mode.toLowerCase() == 'single') {
      player1Paddle = AIPaddle(
        minX: 0,
        maxX: size.x - 50,
        minY: 10,
        maxY: size.y / 2 - 10,
        position: Vector2(size.x / 2, size.y / 10),
        size: Vector2(50, 50),
        puck: puck,
        sprite: paddleSprite,
        //! you can adjust this for difficulty
        aiSpeed: 200,
      );
    } else {
      player1Paddle = Paddle(
        minX: 0,
        maxX: size.x - 50,
        minY: 10,
        maxY: size.y / 2 - 10,
        position: Vector2(size.x / 2, size.y / 10),
        size: Vector2(50, 50),
        puck: puck,
        sprite: paddleSprite,
      );
    }

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

  void displayWinMessage(int player) {
    final message = TextComponent(
      text: 'Player $player Wins!',
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.black, fontSize: 48),
      ),
    );
    message.position = (size - message.size) / 2;
    add(message);

    // Timer to remove the win message after 3 seconds
    add(TimerComponent(
      period: 3,
      onTick: () {
        remove(message);
      },
      repeat: false,
    ));
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