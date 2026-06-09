// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Settings/Gear_setting.dart';

import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';

class GearSettingScreen extends StatefulWidget {
  const GearSettingScreen({super.key});

  @override
  State<GearSettingScreen> createState() => _GearSettingScreenState();
}

class _GearSettingScreenState extends State<GearSettingScreen> {
  //////////////////////////////////////////////////////////
  /// COLOR

  Color all_color = Colors.red;

  //////////////////////////////////////////////////////////
  /// CONTROLLERS

  final TextEditingController big_gear_controller = TextEditingController();

  final TextEditingController small_gear_controller = TextEditingController();

  //////////////////////////////////////////////////////////
  /// UNIT

  String selected_unit = "mm";

  //////////////////////////////////////////////////////////
  /// INIT

  @override
  void initState() {
    super.initState();

    load_gear_setting();
  }

  //////////////////////////////////////////////////////////
  /// LOAD

  Future<void> load_gear_setting() async {
    GearSetting data = await loadGearSettingFromFile();

    setState(() {
      big_gear_controller.text = data.Big_Gear.toString();

      small_gear_controller.text = data.Small_Gear.toString();

      selected_unit = data.Gear_setting_unit;
    });
  }

  //////////////////////////////////////////////////////////
  /// SAVE

  Future<void> save_gear_setting() async {
    GearSetting data = GearSetting(
      Big_Gear: double.tryParse(big_gear_controller.text) ?? 0,

      Small_Gear: double.tryParse(small_gear_controller.text) ?? 0,

      Gear_setting_unit: selected_unit,
    );

    //------------------------------------------------------

    await saveGearSettingToFile(data);

    //------------------------------------------------------

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Gear Setting Saved Successfully ✅"),
        ),
      );
    }
  }

  //////////////////////////////////////////////////////////
  /// DISPOSE

  @override
  void dispose() {
    big_gear_controller.dispose();

    small_gear_controller.dispose();

    super.dispose();
  }

  //////////////////////////////////////////////////////////
  /// UI

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

      saveKey: "Gear_Setting_Color",

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            //////////////////////////////////////////////////
            /// TITLE
            Text(
              "Gear Setting",

              style: TextStyle(
                color: AppColors.Drawer_text_color,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap(30),

            //////////////////////////////////////////////////
            /// MAIN CONTAINER
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: all_color,

                borderRadius: BorderRadius.circular(25),

                border: Border.all(
                  color: AppColors.Drawer_text_color,
                  width: 2,
                ),

                boxShadow: AppColors.shadow_list,
              ),

              child: Column(
                children: [
                  //////////////////////////////////////////////
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset(
                        AppIcons.motor_belt_Icon,

                        width: 40,

                        color: AppColors.Drawer_text_color,
                      ),

                      Gap(15),

                      Text(
                        "Gear Information",

                        style: TextStyle(
                          color: AppColors.Drawer_text_color,

                          fontSize: 26,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Gap(30),

                  //////////////////////////////////////////////
                  /// BIG GEAR
                  gear_text_field(
                    title: "Big Gear",
                    controller: big_gear_controller,
                  ),
                  Gap(20),
                  //////////////////////////////////////////////
                  /// SMALL GEAR
                  gear_text_field(
                    title: "Small Gear",
                    controller: small_gear_controller,
                  ),
                  Gap(25),
                  //////////////////////////////////////////////
                  /// UNIT
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.Drawer_text_color),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),

                      value: selected_unit,
                      dropdownColor: all_color,
                      underline: const SizedBox(),
                      iconEnabledColor: AppColors.Drawer_text_color,
                      style: TextStyle(
                        color: AppColors.Drawer_text_color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      items: ["mm", "cm", "m"]
                          .map(
                            (unit) => DropdownMenuItem(
                              value: unit,
                              child: Text(unit),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selected_unit = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Gap(35),
            //////////////////////////////////////////////////
            /// SAVE BUTTON
            InkWell(
              onTap: () async {
                await save_gear_setting();
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 60,
                width: 220,
                decoration: BoxDecoration(
                  color: all_color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppColors.shadow_list,
                ),
                child: Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// TEXT FIELD

  Widget gear_text_field({
    required String title,

    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Image.asset(
          AppIcons.Gear_Icon,
          color: AppColors.Drawer_text_color,
          width: 30,
        ),
        Gap(20),
        Expanded(
          child: TextField(
            controller: controller,

            keyboardType: const TextInputType.numberWithOptions(decimal: true),

            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],

            style: TextStyle(
              color: AppColors.Drawer_text_color,
              fontWeight: FontWeight.bold,
            ),

            decoration: InputDecoration(
              labelText: title,

              // prefixIcon: Icon(icon, color: AppColors.Drawer_text_color),
              labelStyle: TextStyle(color: AppColors.Drawer_text_color),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),

                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 2,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),

                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
