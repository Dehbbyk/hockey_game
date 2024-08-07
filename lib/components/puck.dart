import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/components/paddle.dart';
import 'package:hockey_game/components/background_border.dart';

class Puck extends SpriteComponent with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  bool isInitialHit = false;

  Puck({required Sprite sprite})
      : super(
    sprite: sprite,
    size: Vector2(20, 20),
    anchor: Anchor.center,
  ) {
    add(CircleHitbox());
  }

  double get radius => size.x / 2;

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    position = gameSize / 2;
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
        velocity = Vector2(200, other.velocity.y);
        isInitialHit = true;
      } else {
        Vector2 direction = (position - other.position).normalized();
        position += direction * (radius + other.size.x / 2);
        velocity = direction * velocity.length;
        velocity += other.velocity * 30.0;
      }

    } else if (other is BackgroundBorder) {
      // Handle collision with the background border
      Vector2 normal = (position - other.position).normalized();
      velocity = velocity - normal * 2 * velocity.dot(normal);
    }
  }
}
