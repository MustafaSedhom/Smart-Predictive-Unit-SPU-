import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "ADD SCREEN",
          style: TextStyle(fontSize: 50, color: AppColors.Drawer_text_color),
        ),
      ],
    );
  }
}
