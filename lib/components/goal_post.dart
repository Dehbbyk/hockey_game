import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/components/puck.dart';

class GoalPost extends RectangleComponent with CollisionCallbacks, HasGameRef<GlowHockeyGame> {
  final int player;
  final Paint paint;

  GoalPost({
    required this.player,
    required Vector2 size,
    required Vector2 position,
    Color color = const Color(0xFF000000), // Default to black
  }) : paint = Paint()..color = color,
        super(size: size, position: position) {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Puck) {
      gameRef.gameEngine.scoreGoal(player);
      other.position = gameRef.size / 2; // Reset puck position after scoring
      other.velocity = Vector2.zero(); // Stop puck movement

      // Reset paddles to initial positions
      gameRef.resetPaddles();
    }
  }
}
