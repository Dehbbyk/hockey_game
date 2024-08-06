

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/components/paddle.dart';
import 'package:hockey_game/UI/game.dart';

class Puck extends CircleComponent with HasGameRef<GlowHockeyGame>,CollisionCallbacks {
  Puck() : super(radius: 10, paint: Paint()
    ..color = Colors.white) {
    add(CircleHitbox());
  }

  Vector2 velocity = Vector2.zero(); // Start with zero velocity
  bool isInitialHit = false;// Initial velocity of the puck

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

    // Check for collisions with the edges of the screen
    if (position.x - radius < 0) {
      position.x = radius;
      velocity.x = -velocity.x;
    } else if (position.x + radius > gameRef.size.x) {
      position.x = gameRef.size.x - radius;
      velocity.x = -velocity.x;
    }

    if (position.y - radius < 0) {
      position.y = radius;
      velocity.y = -velocity.y;
    } else if (position.y + radius > gameRef.size.y) {
      position.y = gameRef.size.y - radius;
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