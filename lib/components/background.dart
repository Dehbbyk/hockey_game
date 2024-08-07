import 'package:flame/components.dart';

class Background extends SpriteComponent {
  Background(Sprite sprite)
      : super(
    sprite: sprite,
    size: Vector2(800, 600), // Set the size according to your game's dimensions
  );

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size = gameSize; // Adjust the size to fill the game area
    position = Vector2.zero(); // Position it at the top-left corner
  }
}
