import 'package:flutter/material.dart';
import 'package:hockey_game/UI/main_menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
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
                    'GLOW HOCKEY',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'ABOUT',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'VERSION',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      '1.0.0',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'DEVELOPED BY',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'DEBORAH KOLAWOLE\nPROMISE OGUNKA\nJOEL ACHI\nAKINWALE DAMILARE',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Text(
                  'INFO & SUPPORT',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'https://github.com/Dehbbyk\n/hockey_game',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainMenuScreen()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
