import 'package:flutter/material.dart';
import 'package:hockey_game/UI/about_screen.dart';
import 'package:hockey_game/UI/difficulty_level.dart';
import 'package:hockey_game/UI/widgets/mainmenu_button.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
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
                MainMenuButton(text: 'SETTINGS', onTap: () {}),
                MainMenuButton(text: 'MORE APPS', onTap: () {}),
                MainMenuButton(text: 'ABOUT', onTap: () => navigateToAbout(context)),
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

  void navigateToAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutScreen()),
    );
  }
}
