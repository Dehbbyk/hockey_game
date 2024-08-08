import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/components/background_border.dart';
import 'package:hockey_game/components/paddle.dart';

class Puck extends SpriteComponent
    with HasGameRef<GlowHockeyGame>, CollisionCallbacks {
  Vector2 velocity = Vector2.zero();
  bool isInitialHit = false;
  final double maxSpeed = 500;

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

    // Ensure the puck does not move too fast
    if (velocity.length > maxSpeed) {
      velocity = velocity.normalized() * maxSpeed;
    }

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
    } else {
      // Calculate the reflection vector
      Vector2 normal = (position - other.position).normalized();
      velocity = velocity - normal * 2 * velocity.dot(normal);
    }
    addCollisionEffect(position);
  }
  void addCollisionEffect(Vector2 position) {
  FlameAudio.play('collision_sound.mp3');  // Play collision sound
  final effect = SpriteComponent(
  sprite: gameRef.collisionEffectSprite,
  size: Vector2(30, 30),
  position: position,
  anchor: Anchor.center,
  );
  gameRef.add(effect);
  effect.add(RemoveEffect(delay: 0.5)); // Remove the effect after 0.5 seconds
  }
}
