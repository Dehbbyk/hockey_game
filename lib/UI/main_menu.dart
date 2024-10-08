import 'package:flutter/material.dart';
import 'package:hockey_game/UI/about_screen.dart';
import 'package:hockey_game/UI/play_options.dart';
import 'package:hockey_game/UI/widgets/mainmenu_button.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

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
                    'GLOW HOCKEY',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MainMenuButton(
                  text: 'PLAY',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlayOptionsScreen()),
                  ),
                ),
                MainMenuButton(text: 'SETTINGS', onTap: () {}),
                MainMenuButton(
                    text: 'ABOUT', onTap: () => navigateToAbout(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutScreen()),
    );
  }
}
