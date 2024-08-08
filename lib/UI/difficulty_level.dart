import 'package:flutter/material.dart';
import 'package:hockey_game/UI/game_screen.dart';
import 'package:hockey_game/UI/widgets/difficulty_button.dart';

class DifficultyLevelScreen extends StatelessWidget {
  const DifficultyLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/main.jpg', // Path to your background image
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Select Difficulty Level',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                DifficultyButton(
                    text: 'Easy', onTap: () => navigateToGame(context, 'Easy')),
                DifficultyButton(
                    text: 'Medium',
                    onTap: () => navigateToGame(context, 'Medium')),
                DifficultyButton(
                    text: 'Hard', onTap: () => navigateToGame(context, 'Hard')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToGame(BuildContext context, String difficulty,
      {String mode = "single"}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GameScreen(difficulty: difficulty, mode: mode)),
    );
  }
}
