import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Draw_all_screens.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DrawAllScreens()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(AppImages.Start_screen_Image, fit: BoxFit.cover),
      ),
    );
  }
}
