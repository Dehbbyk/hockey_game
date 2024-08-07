import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

class GameScreen extends StatelessWidget {
  final String difficulty;

  const GameScreen({super.key, required this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Glow Hockey - $difficulty'),
      // ),
      body: GameWidget(
        game: GlowHockeyGame(),
      ),
    );
  }
}
