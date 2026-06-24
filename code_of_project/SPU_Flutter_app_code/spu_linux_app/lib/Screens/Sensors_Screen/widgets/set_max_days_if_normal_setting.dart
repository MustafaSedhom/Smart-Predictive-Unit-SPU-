import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Settings/Max_Days_settings.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/Custom_container_for_max_days.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';
import 'package:spu_linux_app/widgets/custom_snake_bar.dart';

class SetMaxDaysIfNormalSetting extends StatefulWidget {
  const SetMaxDaysIfNormalSetting({super.key});

  @override
  State<SetMaxDaysIfNormalSetting> createState() =>
      _SetMaxDaysIfNormalSettingState();
}

class _SetMaxDaysIfNormalSettingState extends State<SetMaxDaysIfNormalSetting> {
  Color all_color = Colors.red;

  //---------------------------------------------------------
  // VALUES
  //---------------------------------------------------------

  String motorValue = "∞";
  String pumpValue = "∞";
  String beltValue = "∞";

  //---------------------------------------------------------
  // INIT STATE
  //---------------------------------------------------------

  @override
  void initState() {
    super.initState();

    loadMaxDays();
  }

  //---------------------------------------------------------
  // LOAD
  //---------------------------------------------------------

  Future<void> loadMaxDays() async {
    MaxDaysSettings data = await loadMaxDaysSettingsFromFile();

    setState(() {
      motorValue = data.Motor_Max_Normal_Days;
      pumpValue = data.Pump_Max_Normal_Days;
      beltValue = data.Belt_Max_Normal_Days;
    });
  }

  //---------------------------------------------------------
  // SAVE
  //---------------------------------------------------------

  Future<void> saveMaxDays() async {
    MaxDaysSettings data = MaxDaysSettings(
      Motor_Max_Normal_Days: motorValue,
      Pump_Max_Normal_Days: pumpValue,
      Belt_Max_Normal_Days: beltValue,
    );

    await saveMaxDaysSettingsToFile(data);

    //------------------------------------------------------

    if (mounted) {
       custom_snake_bar(
        context,
        "Max Days Saved Successfully ",
        Colors.green,
      );
    }
  }

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
                    text: "AC Motor Max Days",
                    color: all_color,
                    shadow: AppColors.shadow_list,
                    current_val: motorValue,
                    get_value: (value) {
                      motorValue = value;
                      saveMaxDays();
                    },
                  ),
                  Gap(20),
                  CustomContainerForMaxDays(
                    icon: AppIcons.motor_belt_Icon,
                    text: "Belt Max Days",
                    color: all_color,
                    shadow: AppColors.shadow_list,
                    get_value: (value) {
                      beltValue = value;
                      saveMaxDays();
                    },
                    current_val: beltValue,
                  ),
                  Gap(20),
                  CustomContainerForMaxDays(
                    icon: AppIcons.motor_pump_Icon,
                    text: "DC Motor Max Days",
                    color: all_color,
                    shadow: AppColors.shadow_list,
                    get_value: (value) {
                      pumpValue = value;
                      saveMaxDays();
                    },
                    current_val: pumpValue,
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
