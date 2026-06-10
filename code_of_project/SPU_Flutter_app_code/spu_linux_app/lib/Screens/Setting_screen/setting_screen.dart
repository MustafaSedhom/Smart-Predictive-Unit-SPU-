// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/Admin/Admin_Settings.dart';

import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/widgets/Custom_changes.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Admin_Setting.dart';

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
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  bool EmailLoading = false;
  bool PhoneLoading = false;

  Future<void> saveAdminData() async {
    final email = EmailController.text.trim();
    final phone = PhoneController.text.trim();

    // 1. Save in JSON file
    final admin = await loadAdminSettingsFromFile();

    admin.Email = email;
    admin.Phone = phone;

    await saveAdminSettingsToFile(admin);

    // 2. Save in SharedPreferences (cache / quick access)
  }

  Future<void> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('admin_email') ?? '';

    setState(() {
      EmailController.text = email;
    });
  }

  Future<void> loadPhone() async {
    final prefs = await SharedPreferences.getInstance();

    String phone = prefs.getString('admin_phone') ?? '';

    setState(() {
      PhoneController.text = phone;
    });
  }

  Future<void> saveEmail() async {
    setState(() => EmailLoading = true);

    final email = EmailController.text.trim();
    final prefs = await SharedPreferences.getInstance();

    // 1. Update JSON
    final admin = await loadAdminSettingsFromFile();
    admin.Email = email;
    await saveAdminSettingsToFile(admin);

    // 2. Update SharedPreferences
    await prefs.setString('admin_email', email);

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => EmailLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email saved successfully ✅'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> savePhone() async {
    setState(() => PhoneLoading = true);

    final phone = PhoneController.text.trim();
    final prefs = await SharedPreferences.getInstance();

    // 1. Update JSON
    final admin = await loadAdminSettingsFromFile();
    admin.Phone = phone;
    await saveAdminSettingsToFile(admin);

    // 2. Update SharedPreferences
    await prefs.setString('admin_phone', phone);

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => PhoneLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number saved successfully ✅'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadEmail();
    loadPhone();
  }

  @override
  void dispose() {
    EmailController.dispose();
    PhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
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
                  "Admin Setting",
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
          Gap(5),
          // change email
          CustomChanges(
            controller: EmailController,
            title: "    Admin Email :            ",
            hint: "Enter new email",
            prefix_icon: Icons.email,
            is_saved: EmailLoading,
            ontap_prefix_icon: () {},
            save_operation: saveEmail,
          ),
          //divider
          CustomDivider(),
          Gap(5),
          // change phone number
          CustomChanges(
            controller: PhoneController,
            title: "Admin Phone Number : ",
            hint: "Enter new phone number",
            prefix_icon: Icons.phone,
            is_saved: PhoneLoading,
            ontap_prefix_icon: () {},
            save_operation: savePhone,
          ),
          //divider
          CustomDivider(),
          Gap(5),
          // change images
          SizedBox(
            width: screen_width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Gap(0.05 * screen_width),
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
                  Gap(0.15 * screen_width),
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
            ),
          ),
        ],
      ),
    );
  }
}
