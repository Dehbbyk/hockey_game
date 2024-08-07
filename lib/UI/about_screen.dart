import 'package:flutter/material.dart';
import 'package:hockey_game/UI/main_menu.dart';

class AboutScreen extends StatelessWidget {
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
                Text(
                  'ABOUT',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'VERSION',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      '1.0.0',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'DEVELOPED BY',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'DEBORAH  KOLAWOLE\nPROMISE   OGUNKA\nJOEL      ACHI\nDAMILARE  AKINWALE\nQUADRI      AJAGBE',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'INFO & SUPPORT',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.red.shade100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'https://github.com/Dehbbyk\n/hockey_game',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainMenuScreen()),
                    );
                  },
                  icon: Icon(Icons.arrow_back),
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
