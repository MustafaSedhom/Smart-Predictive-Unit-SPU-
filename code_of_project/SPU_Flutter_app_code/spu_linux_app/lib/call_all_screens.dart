import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/Home_Screen.dart';
import 'package:spu_linux_app/Screens/Start_screen/start_screen.dart';

// ignore: camel_case_types
class SPU_Linux_APP extends StatelessWidget {
  const SPU_Linux_APP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPU Linux App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomeScreen(),
      home: StartScreen(),
    );
  }
}
