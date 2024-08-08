import 'package:flame/components.dart';

class GameEngine extends Component {
  int player1Score = 0;
  int player2Score = 0;
  int lastScorer = 0;

  Function(int, int)? onScoreChanged;

  void scoreGoal(int player) {
    lastScorer = player;
    if (player == 1) {
      player1Score++;
    } else if (player == 2) {
      player2Score++;
    }
    onScoreChanged?.call(player1Score, player2Score);
    print('Player $player scored! Score: $player1Score - $player2Score');
  }
}
