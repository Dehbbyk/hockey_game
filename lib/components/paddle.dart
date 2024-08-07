import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:hockey_game/components/puck.dart';

class Paddle extends PositionComponent with DragCallbacks {
  final Color color;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final Puck puck;
  late Paint paint; // Define paint here

  Paddle({
    required this.color,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required Vector2 position,
    Vector2? size,
    required this.puck,
  }) : super(
          position: position,
          size: size ?? Vector2(20, 100), // Default size of the paddle
          anchor: Anchor.center,
        ) {
    paint = Paint()..color = color; // Initialize paint with the paddle color
    add(RectangleHitbox()); // Add hitbox for collision detection
  }

  Vector2 velocity = Vector2.zero();

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), paint); // Use the paint object for drawing
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    // Move the paddle within the allowed vertical range
    Vector2 newPosition = position + event.canvasDelta;
    // Clamp the position within the allowed range
    newPosition.x = newPosition.x.clamp(minX, maxX);
    newPosition.y = newPosition.y.clamp(minY, maxY);
    velocity = event.canvasDelta;
    position = newPosition;

    // Check for collision with puck
    if (puck.containsPoint(position + size / 2)) {
      puck.velocity = velocity.normalized() * puck.velocity.length;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    // Reset the velocity when the drag ends
    velocity = Vector2.zero();
  }
}
