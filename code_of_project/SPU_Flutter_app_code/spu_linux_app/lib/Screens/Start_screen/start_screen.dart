import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/Home_Screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    // 2. Start the timer as soon as the screen loads
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 1), () {
      // 3. Navigation Logic
      if (mounted) {
        // Check if the widget is still in the tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          "assets/images/Start_screen_img.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
