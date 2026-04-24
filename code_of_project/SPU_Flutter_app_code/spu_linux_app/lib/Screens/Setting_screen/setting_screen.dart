// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Admin_Setting.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  final VoidCallback? advanced_setting_ontap;
  const SettingScreen({super.key, this.advanced_setting_ontap});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // double screen_hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(20),
          //Appbar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Gap(5),

              Text(
                "SETTING",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.Drawer_text_color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  // ignore: deprecated_member_use
                  hoverColor: AppColors.Drawer_icon_selected_color.withOpacity(
                    0.5,
                  ),

                  radius: 50,
                  borderRadius: BorderRadius.circular(50),
                  onTap: widget.advanced_setting_ontap,
                  child: Icon(
                    Icons.settings_suggest,
                    color: AppColors.Drawer_text_color,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          AdminSetting(),
        ],
      ),
    );
  }
}
