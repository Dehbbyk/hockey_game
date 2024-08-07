import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hockey_game/game.dart';
import 'package:hockey_game/splash_screen.dart';

void main() {
  runApp(const MyApp());
  // runApp(
  //   GameWidget(game: GlowHockeyGame()),
  // );
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
      home: const SplashScreen(),
    );
  }
}














class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: GlowHockeyGame(),
      ),
    );
  }
}
