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
          Positioned.fill(
            child: Image.asset(
              'assets/images/main.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Difficulty Level',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DifficultyButton(text: 'Easy', onTap: () => navigateToGame(context, 'Easy')),
                DifficultyButton(text: 'Medium', onTap: () => navigateToGame(context, 'Medium')),
                DifficultyButton(text: 'Hard', onTap: () => navigateToGame(context, 'Hard')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToGame(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen(difficulty: difficulty)),
    );
  }
}
