import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/components/paddle.dart';

class Puck extends CircleComponent
    with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Puck() : super(radius: 13, paint: Paint()..color = Colors.white) {
    add(CircleHitbox());
  }

  Vector2 velocity =
      Vector2.zero(); // Flag to indicate if the puck has been hit initially
  bool isInitialHit = false; // Initial velocity of the puck

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = Vector2(
        gameSize.x / 2.1,
        gameSize.y / 2 -
            radius); // Position the puck at the center once the game size is known
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Bounce off the left and right edges
    if (position.x - radius < 0) {
      position.x = radius;
      velocity.x = -velocity.x;
    } else if (position.x + radius > gameRef.size.x) {
      position.x = gameRef.size.x - radius;
      velocity.x = -velocity.x;
    }

    // Bounce off the top and bottom edges
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
        velocity = Vector2(200, other.velocity.y);
        isInitialHit = true;
      } else {
        // Reverse the direction of the puck on collision with a paddle/ stops overlapping
        Vector2 direction = (position - other.position).normalized();
        position += direction * (radius + other.size.x / 2);

        // Add the paddle's velocity to the puck's velocity for more realistic interaction
        velocity = direction * velocity.length;
        velocity += other.velocity *
            10.0; //this controls the force of puk bounce from the paddle
      }
    }
  }
}
