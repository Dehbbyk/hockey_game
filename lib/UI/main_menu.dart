import 'package:flutter/material.dart';
import 'package:hockey_game/UI/difficulty_level.dart';
import 'package:hockey_game/UI/widgets/mainmenu_button.dart';


class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
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
            MainMenuButton(text: 'CHAMPIONSHIP', onTap: () => navigateToDifficulty(context)),
            MainMenuButton(text: '1 PLAYER', onTap: () => navigateToDifficulty(context)),
            MainMenuButton(text: '2 PLAYER', onTap: () => navigateToDifficulty(context)),
            MainMenuButton(text: 'SETTINGS', onTap: () => navigateToDifficulty(context)),
            MainMenuButton(text: 'MORE APPS', onTap: () => navigateToDifficulty(context)),
            MainMenuButton(text: 'ABOUT', onTap: () => navigateToDifficulty(context)),
          ],
        ),
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
