import 'package:flutter/material.dart';
import 'package:hockey_game/difficulty_level.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/background.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'GLOW HOCKEY',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              MainMenuButton(text: 'CHAMPIONSHIP', onTap: () {}),
              MainMenuButton(
                  text: '1 PLAYER', onTap: () => navigateToDifficulty(context)),
              MainMenuButton(
                  text: '2 PLAYER', onTap: () => navigateToDifficulty(context)),
              MainMenuButton(text: 'SETTINGS', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDifficulty(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DifficultyLevelScreen()),
    );
  }
}

class MainMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MainMenuButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 220,
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
