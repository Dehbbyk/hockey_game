import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class GameScreen extends StatelessWidget {
  final String? difficulty;
  final String mode;

  const GameScreen({super.key, this.difficulty, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameWidget(
          game: GlowHockeyGame(mode: mode),
        ),
      ),
    );
  }
}
