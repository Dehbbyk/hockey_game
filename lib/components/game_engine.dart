import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:hockey_game/UI/game.dart';

class GameEngine extends Component with HasGameRef<GlowHockeyGame>{
  int player1Score = 0;
  int player2Score = 0;

  Function(int, int)? onScoreChanged;

  void scoreGoal(int player) {
    if (player == 1) {
      player1Score++;
    } else if (player == 2) {
      player2Score++;
    }
    FlameAudio.play('goal_sound.mp3');  // Play goal sound
    gameRef.displayWinMessage(player);
    gameRef.resetPaddles();
    onScoreChanged?.call(player1Score, player2Score);
    print('Player $player scored! Score: $player1Score - $player2Score');
  }

}
