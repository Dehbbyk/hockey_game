import 'package:flame/components.dart';
import 'package:hockey_game/components/paddle.dart';

import '../UI/game.dart';

class AIPaddle extends Paddle with HasGameRef<GlowHockeyGame> {
  final double aiSpeed;
  bool shouldMove = true;
  double activationTimer = 0;
  double delayBeforeActivation = 1.0;
  Vector2 lastPosition = Vector2.zero();
  double stuckTimer = 0;
  final double stuckThreshold =
      2; // Time threshold to consider the paddle stuck

  // this defines the defensive zone as the area in front of the AI's goal post
  final double defensiveZoneHeight;
  final double goalLine;

  AIPaddle({
    required super.sprite,
    required super.minX,
    required super.maxX,
    required super.minY,
    required super.maxY,
    required super.position,
    super.size,
    required super.puck,
    required this.aiSpeed,
    this.defensiveZoneHeight =
        100, // Height of the defensive zone in front of the goal post
  }) : goalLine = minY;

  @override
  void update(double dt) {
    super.update(dt);

    if (gameRef.gameEngine.lastScorer == 2) {
      activationTimer += dt;
      if (activationTimer >= delayBeforeActivation) {
        shouldMove = true;
      }
    } else {
      shouldMove = true;
    }

    if (shouldMove) {
      moveToPuck(dt);
    }
  }

  void moveToPuck(double dt) {
    double defensiveZoneTop = minY;
    double defensiveZoneBottom = minY + defensiveZoneHeight;

    bool isAITurn = gameRef.gameEngine.lastScorer == 2;
    bool puckIsMoving = puck.velocity.length > 0.1;

    if (isAITurn && !puckIsMoving) {
      return;
    }

    bool inDefensiveZone = puck.position.y >= defensiveZoneTop &&
        puck.position.y <= defensiveZoneBottom;

    final direction = (puck.position - position).normalized();

    if (inDefensiveZone) {

      if ((puck.position.y <= defensiveZoneBottom) &&
          (position.y > defensiveZoneTop)) {
        // Move the paddle towards the puck horizontally but slower
        if (puck.position.x < position.x) {
          velocity.x = -aiSpeed * 1.0;
        } else if (puck.position.x > position.x) {
          velocity.x = aiSpeed * 1.0;
        } else {
          velocity.x = 0;
        }

        // Slightly move the paddle towards the goal vertically
        if (puck.position.y < position.y) {
          velocity.y = -aiSpeed * 0.5;
        } else {
          velocity.y = 0;
        }
      } else {
        // If the puck is too close to the goal, move to block it
        velocity = (Vector2(minX + (maxX - minX) * 0.5, minY) - position)
                .normalized() *
            aiSpeed *
            0.3;
      }
    } else {
      // If not in defensive mode, follow the puck normally
      velocity = direction * aiSpeed;
    }

    // Move the paddle towards the puck
    position += velocity * dt;

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

  void resumeMovement() {
    shouldMove = true;
  }
}
