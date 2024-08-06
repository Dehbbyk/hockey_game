
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class HockeyTable extends PositionComponent {
  late Paint topPaint;
  late Paint bottomPaint;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.topLeft;
    topPaint = BasicPalette.red.paint();
    bottomPaint = BasicPalette.blue.paint();
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    // Set the size to fill the game area
    size = gameSize;
    // Position at the top left corner of the game area
    position = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw the main playing area
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y * 0.5), topPaint);
    // Draw a glowing border around the playing area
    canvas.drawRect(
        Rect.fromLTWH(0, size.y * 0.5, size.x, size.y * 0.5), bottomPaint);
  }
}
