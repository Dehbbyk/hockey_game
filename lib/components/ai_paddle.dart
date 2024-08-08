import 'package:flame/components.dart';
import 'package:hockey_game/components/paddle.dart';

class AIPaddle extends Paddle {
  final double aiSpeed;
  Vector2 lastPosition = Vector2.zero();
  double stuckTimer = 0;
  final double stuckThreshold =
      2; // Time threshold to consider the paddle stuck

  AIPaddle({
    required super.sprite,
    required super.minX,
    required super.maxX,
    required super.minY,
    required super.maxY,
    required super.position,
    super.size,
    required super.puck,
    this.aiSpeed = 300, // Default speed
  });

  @override
  void update(double dt) {
    super.update(dt);

    // Calculate direction towards the puck
    final direction = (puck.position - position).normalized();

    // Move the paddle towards the puck
    final displacement = direction * aiSpeed * dt;
    position += displacement;

    // Ensure the AI paddle doesn't get too close without bouncing
    if ((puck.position - position).length < puck.size.x / 2 + size.x / 2 + 2) {
      puck.velocity = direction * 200;
      position -= direction * 10 * dt;
    }

    // Ensure the paddle stays within the allowed range
    position.x = position.x.clamp(minX, maxX);
    position.y = position.y.clamp(minY, maxY);

    // Check if the AI paddle is stuck in the same position for too long
    if ((lastPosition - position).length < 1) {
      stuckTimer += dt;
    } else {
      stuckTimer = 0;
      lastPosition = position.clone();
    }

    // If the paddle is stuck, move it to a different position
    if (stuckTimer > stuckThreshold) {
      // Move the paddle away from the puck or to a random position within the allowed range
      position =
          Vector2(minX + (maxX - minX) * 0.5, minY + (maxY - minY) * 0.5);
      stuckTimer = 0; // Reset the stuck timer
    }
  }
}
