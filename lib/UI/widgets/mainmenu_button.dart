import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const MainMenuButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(13.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
