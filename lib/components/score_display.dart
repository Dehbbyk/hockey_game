import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/UI/game.dart';

class ScoreDisplay extends TextComponent with HasGameRef<GlowHockeyGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    text = '0 - 0';
    textRenderer = TextPaint(style: textStyle);
    print("ScoreDisplay loaded");
  }

  @override
  void onMount() {
    super.onMount();
    position =
        Vector2(gameRef.size.x / 2 - measureTextWidth(text, textStyle) / 2, 10);
    print("ScoreDisplay mounted: position = $position");
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position =
        Vector2(gameSize.x / 2 - measureTextWidth(text, textStyle) / 2, 10);
    print("ScoreDisplay resized: position = $position");
  }

  void updateText(int player1Score, int player2Score) {
    text = '$player1Score - $player2Score';
    final textWidth = measureTextWidth(text, textStyle);
    position.x =
        (gameRef.size.x - textWidth) / 2; // Recenter text when it changes
    print("Score updated: $text");
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    textRenderer.render(canvas, text, Vector2(position.x, position.y));
  }
}

const textStyle = TextStyle(color: Colors.white, fontSize: 24);

double measureTextWidth(String text, TextStyle style) {
  final textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
