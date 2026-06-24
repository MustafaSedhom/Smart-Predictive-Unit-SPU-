// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/Admin/Admin_Settings.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/widgets/Custom_changes.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Admin_Setting.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/SPU_logo_Setting.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';
import 'package:spu_linux_app/widgets/custom_snake_bar.dart';

class SettingScreen extends StatefulWidget {
  final VoidCallback? advancedSettingOnTap;
  const SettingScreen({super.key, this.advancedSettingOnTap});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool emailLoading = false;
  bool phoneLoading = false;

  @override
  void initState() {
    super.initState();
    loadEmail();
    loadPhone();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailController.text = prefs.getString('admin_email') ?? '';
    });
  }

  Future<void> loadPhone() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneController.text = prefs.getString('admin_phone') ?? '';
    });
  }

  Future<void> saveEmail() async {
    setState(() => emailLoading = true);
    final email = emailController.text.trim();
    final prefs = await SharedPreferences.getInstance();

    final admin = await loadAdminSettingsFromFile();
    admin.Email = email;
    await saveAdminSettingsToFile(admin);

    await prefs.setString('admin_email', email);
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    setState(() => emailLoading = false);

    custom_snake_bar(
      context,
      'Email config updated successfully',
      const Color(0xFF00F5D4),
    );
  }

  Future<void> savePhone() async {
    setState(() => phoneLoading = true);
    final phone = phoneController.text.trim();
    final prefs = await SharedPreferences.getInstance();

    final admin = await loadAdminSettingsFromFile();
    admin.Phone = phone;
    await saveAdminSettingsToFile(admin);

    await prefs.setString('admin_phone', phone);
    await Future.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;
    setState(() => phoneLoading = false);

    custom_snake_bar(
      context,
      'Comms pipeline phone saved',
      const Color(0xFF00F5D4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1F38), Color(0xFF0F111A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'ADMIN CONTROL PANEL',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.white.withOpacity(0.04),
                      child: InkWell(
                        hoverColor: const Color(0xFF3B82F6).withOpacity(0.15),
                        onTap: widget.advancedSettingOnTap,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          // decoration: Border.all(
                          //   color: Colors.white10,
                          // ),//.wrap(BoxDecoration), // compatibility fallback
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppIcons.Advance_setting_Icon,
                                width: 18,
                                height: 18,
                                color: const Color(0xFF3B82F6),
                              ),
                              const Gap(8),
                              const Text(
                                "Advanced",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("GATEWAY SYSTEM CONTACTS", Icons.hub_outlined),
            const Gap(12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF141726),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Column(
                children: [
                  CustomChanges(
                    controller: emailController,
                    title: "System Admin Email",
                    hint: "Enter alert routing email",
                    prefix_icon: Icons.alternate_email_rounded,
                    is_saved: emailLoading,
                    ontap_prefix_icon: () {},
                    save_operation: saveEmail,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomDivider(),
                  ),
                  CustomChanges(
                    controller: phoneController,
                    title: "SMS Gateway Phone",
                    hint: "Enter telemetry phone number",
                    prefix_icon: Icons.phone_android_rounded,
                    is_saved: phoneLoading,
                    ontap_prefix_icon: () {},
                    save_operation: savePhone,
                  ),
                ],
              ),
            ),
            const Gap(28),
            _buildSectionHeader("HMI DISPLAY GRAPHICS", Icons.layers_outlined),
            const Gap(12),
            Row(
              children: [
                Expanded(
                  child: _buildGraphicCard(
                    "Home Screen Wallpaper",
                    const AdminSetting(),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: _buildGraphicCard(
                    "Corporate SPU Identifier",
                    const SpuLogoSetting(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00F5D4), size: 18),
        const Gap(8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildGraphicCard(String title, Widget settingWidget) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: const Color(0xFF141726),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Gap(4),
          Text(
            "Modify interface asset file",
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 11,
            ),
          ),
          const Gap(14),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF0F111A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.02)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Center(child: settingWidget),
            ),
          ),
        ],
      ),
    );
  }
}
