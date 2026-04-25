// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Gear_setting.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Admin_Setting.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Dimeter_setting_widget.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/SPU_logo_Setting.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  final VoidCallback? advanced_setting_ontap;
  const SettingScreen({super.key, this.advanced_setting_ontap});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController Big_Gear_Controller = TextEditingController();
  TextEditingController Small_Gear_Controller = TextEditingController();
  GearSetting? Gears;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final gearData = await loadGearSettingFromFile();

    // ignore: unnecessary_null_comparison
    if (!mounted || gearData == null) return;

    setState(() {
      Gears = gearData;

      final big = gearData.Big_Gear.toString();
      final small = gearData.Small_Gear.toString();

      if (Big_Gear_Controller.text != big) {
        Big_Gear_Controller.text = big;
      }

      if (Small_Gear_Controller.text != small) {
        Small_Gear_Controller.text = small;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    Big_Gear_Controller.dispose();
    Small_Gear_Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screen_hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10),
          //Appbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Setting",
                  style: CustomAppBarTextStyle.appbar_text_style(size: 25),
                ),
                InkWell(
                  // ignore: deprecated_member_use
                  hoverColor: AppColors.Drawer_icon_selected_color.withOpacity(
                    0.5,
                  ),

                  radius: 50,
                  borderRadius: BorderRadius.circular(50),
                  onTap: widget.advanced_setting_ontap,
                  child: Image.asset(
                    AppIcons.Advance_setting_Icon,
                    width: 30,
                    color: AppColors.Drawer_text_color,
                  ),
                ),
              ],
            ),
          ),
          //divider
          CustomDivider(),
          // Gear Diameter Settings
          Column(
            children: [
              Text(
                "Gear Setting",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.Drawer_icon_selected_color,
                ),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DiameterSettingWidget(
                    controller: Big_Gear_Controller,
                    title: "Big Gear",
                    img: AppIcons.setting_Icon,
                    size: 40,
                    unit: Gears?.Gear_setting_unit ?? "mm",
                    value: Gears?.Big_Gear ?? 0,
                    onChanged: (val) async {
                      Gears?.Big_Gear = val;
                      await saveGearSettingToFile(Gears!);
                    },
                  ),
                  Image.asset(AppIcons.motor_belt_Icon, width: 100),
                  DiameterSettingWidget(
                    controller: Small_Gear_Controller,
                    title: "Small Gear",
                    img: AppIcons.setting_Icon,
                    size: 30,
                    unit: Gears?.Gear_setting_unit ?? "mm",
                    value: Gears?.Small_Gear ?? 0,
                    onChanged: (val) async {
                      Gears?.Small_Gear = val;
                      await saveGearSettingToFile(Gears!);
                    },
                  ),
                ],
              ),
            ],
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
                        color: AppColors.Drawer_icon_selected_color,
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
                        color: AppColors.Drawer_icon_selected_color,
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
          CustomDivider(),
        ],
      ),
    );
  }
}
