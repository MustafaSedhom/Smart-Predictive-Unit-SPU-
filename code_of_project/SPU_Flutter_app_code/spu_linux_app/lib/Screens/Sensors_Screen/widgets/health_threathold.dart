import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';

class HealthThreshold extends StatefulWidget {
  const HealthThreshold({super.key});

  @override
  State<HealthThreshold> createState() => _HealthThresholdState();
}

class _HealthThresholdState extends State<HealthThreshold> {
  Color all_color = Colors.red;
  @override
  Widget build(BuildContext context) {
    
    return ChangesColorContainer(
      onColorChanged: (return_color) async {
        setState(() {
          all_color = return_color;
        });
      },
      shadow: AppColors.shadow_list,
     colors: AppColors.color_list,
      saveKey: "Max_Days_If_Normal_Colors",
      child: Text("data"),
    );
  }
}
