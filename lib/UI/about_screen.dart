import 'package:flutter/material.dart';
import 'package:hockey_game/UI/main_menu.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0, // Size of the icon
          color: Colors.white, // Color of the icon
          padding: EdgeInsets.all(8.0), // Padding around the icon
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainMenuScreen()),
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/image/main.jpg'), // Ensure the image is in the assets folder and listed in pubspec.yaml
      ),
    );
  }
}
