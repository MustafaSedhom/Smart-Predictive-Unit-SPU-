import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Drawer_Widget.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_containers.dart';

/// Flutter code sample for [Drawer].
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [DrawerWidget(), HomeScreenContainers()]),
    );
  }
}
