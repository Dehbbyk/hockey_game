import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class BackgroundBorder extends SpriteComponent with CollisionCallbacks {
  BackgroundBorder(Sprite sprite)
      : super(
    sprite: sprite,
    size: Vector2(800, 600), // Set the size according to your game's dimensions
  );

  // @override
  // Future<void> onLoad() async {
  //   super.onLoad();
  //   add(RectangleHitbox()); // Add a hitbox to the background border
  // }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size = gameSize; // Adjust the size to fill the game area
    position = Vector2.zero(); // Position it at the top-left corner
  }
}
