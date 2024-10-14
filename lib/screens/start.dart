import 'package:flutter/material.dart';
import 'package:furnitui/components/custom_button.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/furniture_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay (black at the bottom to transparent at the top)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.7], 
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                const Text(
                  'Finding the Perfect\nFurniture for Your Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Outlined (Login) button
                CustomButton(
                  text: 'Login',
                  isFilled: false,
                  onPressed: () {
                    // Handle login
                  },
                ),
                const SizedBox(height: 10),
                // Filled (Get Started) button
                CustomButton(
                  text: 'Get Started',
                  isFilled: true,
                  onPressed: () {
                    // Handle get started
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
