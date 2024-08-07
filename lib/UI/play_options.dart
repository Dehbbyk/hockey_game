import 'package:flutter/material.dart';
import 'package:hockey_game/UI/difficulty_level.dart';
import 'package:hockey_game/UI/game_screen.dart';
import 'package:hockey_game/UI/widgets/mainmenu_button.dart';

class PlayOptionsScreen extends StatelessWidget {
  const PlayOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/main.jpg',
            fit: BoxFit.cover,
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'PLAY OPTIONS ',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MainMenuButton(
                    text: 'CHAMPIONSHIP',
                    onTap: () => navigateToDifficulty(context)),
                MainMenuButton(
                    text: '1 PLAYER',
                    onTap: () => navigateToDifficulty(context)),
                MainMenuButton(
                    text: '2 PLAYER',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GameScreen()),
                    ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToDifficulty(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DifficultyLevelScreen()),
    );
  }
}
