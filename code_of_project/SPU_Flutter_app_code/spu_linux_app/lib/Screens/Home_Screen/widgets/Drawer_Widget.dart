import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey,
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(title: Text("Home"), onTap: () {}),
          ListTile(title: Text("Settings"), onTap: () {}),
        ],
      ),
    );
  }
}
