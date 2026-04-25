// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Admin_Setting.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/SPU_logo_Setting.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(20),
          //Appbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SETTING",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Drawer_text_color,
                  ),
                ),
                InkWell(
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
              ],
            ),
          ),
          //divider
          CustomDivider(),
          Gap(5),
          // change images
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Home Screen Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.amber,
                      ),
                    ),
                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AdminSetting(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SPU Logo Image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.amber,
                      ),
                    ),
                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SpuLogoSetting(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //divider
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          //   child: Divider(),
          // ),
        ],
      ),
    );
  }
}
