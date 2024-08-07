
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/components/paddle.dart';

class Puck extends SpriteComponent
    with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Vector2 velocity =
      Vector2.zero(); // Flag to indicate if the puck has been hit initially
  bool isInitialHit = false; // Initial velocity of the puck

  Puck({required Sprite sprite})
      : super(
          sprite: sprite,
          size: Vector2(20, 20),
          anchor: Anchor.center,
        ) {
    add(CircleHitbox());
  }

  double get radius => size.x / 2; // Radius

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
            30.0; //this controls the force of puk bounce from the paddle
      }
    }
  }
}
