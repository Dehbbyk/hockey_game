import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/UI/game.dart';
import 'package:hockey_game/UI/main_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glow Hockey',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  MainMenuScreen(),
    );
  }
}


