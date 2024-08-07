import 'package:flutter/material.dart';
import 'package:hockey_game/game_screen.dart';

class DifficultyLevelScreen extends StatelessWidget {
  const DifficultyLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Select Difficulty Level',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DifficultyButton(
                text: 'Easy', onTap: () => navigateToGame(context, 'Easy')),
            DifficultyButton(
                text: 'Medium', onTap: () => navigateToGame(context, 'Medium')),
            DifficultyButton(
                text: 'Hard', onTap: () => navigateToGame(context, 'Hard')),
          ],
        ),
      ),
    );
  }

  void navigateToGame(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GameScreen(difficulty: difficulty)),
    );
  }
}

class DifficultyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const DifficultyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
