//
//
// import 'package:flame/collisions.dart';
// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:hockey_game/components/paddle.dart';
// import 'package:hockey_game/UI/game.dart';
//
// class Puck extends CircleComponent with HasGameRef<GlowHockeyGame>,CollisionCallbacks {
//   Puck() : super(radius: 10, paint: Paint()
//     ..color = Colors.white) {
//     add(CircleHitbox());
//   }
//
//   Vector2 velocity = Vector2.zero(); // Start with zero velocity
//   bool isInitialHit = false;// Initial velocity of the puck
//
//   @override
//   void onGameResize(Vector2 gameSize) {
//     super.onGameResize(gameSize);
//     position = gameSize /
//         2; // Position the puck at the center once the game size is known
//   }
//
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     position += velocity * dt;
//
// //   Bounce off the left and right edges
//     if (position.x <= 0 || position.x >= gameRef.size.x) {
//       velocity.x = -velocity.x;
//     }
//     // Bounce off the top and bottom edges
//     if (position.y <= 0 || position.y >= gameRef.size.y) {
//       velocity.y = -velocity.y;
//     }
//   }
//
//   @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     super.onCollision(intersectionPoints, other);
//     if (other is Paddle) {
//       if (!isInitialHit) {
//         // Set initial velocity on first hit
//         velocity = Vector2(200, 200);
//         isInitialHit = true;
//       } else {
//         // Reverse the direction of the puck on collision with a paddle
//         velocity.y = -velocity.y;
//         // Add the paddle's velocity to the puck's velocity for more realistic interaction
//         velocity += other.velocity * 0.3;
//       }
//     }
//   }
// }

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/components/paddle.dart';
import 'package:hockey_game/UI/game.dart';

class Puck extends SpriteComponent with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero(); // Start with zero velocity
  bool isInitialHit = false; // Initial velocity of the puck

  Puck({required Sprite sprite}) : super(
    sprite: sprite,
    size: Vector2(20, 20),
    anchor: Anchor.center,
  ) {
    add(CircleHitbox());
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2; // Position the puck at the center once the game size is known
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    // Bounce off the left and right edges
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
