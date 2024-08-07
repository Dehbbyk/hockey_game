import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GlowHockeyGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final hockeyTable = HockeyTable();
    add(hockeyTable);

    final puck = Puck();
    puck.position = hockeyTable.center;
    add(puck);

    add(
      Paddle(
        color: Colors.red.shade300,
        minX: 0, // Left edge of the play area
        maxX: size.x - 50, // Right edge of the play area
        minY: 10, // Top edge of the play area
        maxY: size.y / 2 - 10, // Bottom edge of the red play area
        position: Vector2(size.x / 2, size.y / 10),
        size: Vector2(100, 20),
        puck: puck,
      ),
    );

    add(
      Paddle(
        color: Colors.blue.shade300,
        minX: 0, // Left edge of the play area
        maxX: size.x - 50, // Right edge of the play area
        minY: size.y / 2 + 10, // Top edge of the blue play area
        maxY: size.y - 10, // Bottom edge of the play area
        position: Vector2(size.x / 2, size.y - size.y / 10),
        size: Vector2(100, 20),
        puck: puck,
      ),
    );
  }
}

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

class Puck extends CircleComponent
    with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Puck() : super(radius: 10, paint: Paint()..color = Colors.white) {
    add(CircleHitbox());
  }

  Vector2 velocity = Vector2.zero(); // Start with zero velocity
  bool isInitialHit = false; // Initial velocity of the puck

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize /
        2; // Position the puck at the center once the game size is known
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

//   Bounce off the left and right edges
    if (position.x <= 0 || position.x >= gameRef.size.x) {
      velocity.x = -velocity.x;
    }
    // Bounce off the top and bottom edges
    if (position.y <= 0 || position.y >= gameRef.size.y) {
      velocity.y = -velocity.y;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Paddle) {
      if (!isInitialHit) {
        // Set initial velocity on first hit
        velocity = Vector2(200, 200);
        isInitialHit = true;
      } else {
        // Reverse the direction of the puck on collision with a paddle
        velocity.y = -velocity.y;
        // Add the paddle's velocity to the puck's velocity for more realistic interaction
        velocity += other.velocity * 0.3;
      }
    }
  }
}

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
    // Reset the velocity when the drag ends
    velocity = Vector2.zero();
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
