

import 'package:flame/components.dart';

class HockeyTable extends SpriteComponent {
  HockeyTable({required Sprite sprite}) : super(
    sprite: sprite,
    size: Vector2.all(800), // Assuming the table covers the whole game area
    anchor: Anchor.topLeft,
  );

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size = gameSize; // Resize to fit the game area
    position = Vector2.zero(); // Position at the top left corner
  }
}
