import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/Custom_container_for_max_days.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';

class SetMaxDaysIfNormalSetting extends StatefulWidget {
  const SetMaxDaysIfNormalSetting({super.key});

  @override
  State<SetMaxDaysIfNormalSetting> createState() =>
      _SetMaxDaysIfNormalSettingState();
}

class _SetMaxDaysIfNormalSettingState extends State<SetMaxDaysIfNormalSetting> {
  Color all_color = Colors.red;
  @override
  Widget build(BuildContext context) {
    List<BoxShadow> custom_shadow = [
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
    ];
    return ChangesColorContainer(
      onColorChanged: (return_color) async {
        setState(() {
          all_color = return_color;
        });
      },
      shadow: custom_shadow,
      colors: [
        Colors.green,
        Colors.blue,
        Colors.red,
        Colors.orange,
        Colors.purple,
        Colors.deepPurpleAccent,
        Colors.black,
        Colors.grey,
        Colors.blueGrey,
      ],
      saveKey: "Max_Days_If_Normal_Colors",
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // AppBar
              Text(
                "Normal Max Days ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Gap(20),
              // Boxes
              Row(
                children: [
                  Gap(20),
                  CustomContainerForMaxDays(
                    icon: AppIcons.motor_Icon,
                    text: "Motor Max Days",
                    color: all_color,
                    shadow: custom_shadow,
                  ),
                  Gap(20),
                  CustomContainerForMaxDays(
                    icon: AppIcons.motor_belt_Icon,
                    text: "Belt Max Days",
                    color: all_color,
                    shadow: custom_shadow,
                  ),
                  Gap(20),
                  CustomContainerForMaxDays(
                    icon: AppIcons.motor_pump_Icon,
                    text: "Pump Max Days",
                    color: all_color,
                    shadow: custom_shadow,
                  ),
                  Gap(20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
