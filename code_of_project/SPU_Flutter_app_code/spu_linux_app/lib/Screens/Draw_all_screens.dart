// ignore_for_file: use_build_context_synchronously, unused_local_variable, unnecessary_nullable_for_final_variable_declarations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/Belt_Driver_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Motor_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Pump_Card_Data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Providers/machine_provider.dart';
import 'package:spu_linux_app/Screens/Add_Card_Screen/Add_Card_Screen.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/Advanced_settings_screen.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/machine_card_data.dart';
import 'package:spu_linux_app/Screens/Last_Data_Screen.dart/Actuators_Last_Data_screen.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/Sensors_Screen.dart';
import 'package:spu_linux_app/widgets/Password_dialog.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Alarm_Screen.dart';
import 'package:spu_linux_app/Screens/Analysis_Screen/Analysis_screen.dart';
import 'package:spu_linux_app/Screens/Details_screen/Details_screen.dart';
import 'package:spu_linux_app/Screens/Home_Screen/Home_Screen.dart';
import 'package:spu_linux_app/Screens/Setting_screen/setting_screen.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Drawer/Drawer_Widget.dart';
import 'package:spu_linux_app/widgets/Drawer/widgets/Drawer_items.dart';

// ignore: must_be_immutable
class DrawAllScreens extends StatefulWidget {
  const DrawAllScreens({super.key});

  @override
  State<DrawAllScreens> createState() => _DrawAllScreensState();
}

class _DrawAllScreensState extends State<DrawAllScreens> {
  List<MachineCardData> default_cards = [];
  Timer? _dataTimer;
  void loadData() async {
    final Motor? motorData = await loadMotorFromFile();
    final Pump? pumpData = await loadPumpFromFile();
    final BeltDriver? beltDriverData = await loadBeltDriverFromFile();
    if (!mounted) return;

    final cards = [
      MachineCardData(
        value: (motorData?.Health ?? 0).toDouble(),
        name: 'AC MOTOR',
        img: AppImages.motor_Image,
        imgIcon: AppIcons.motor_Icon,
        statusName: motorData?.status ?? "None",
        sensor_1_name: 'Temperature',
        sensor_1_value: '${motorData?.Temperature ?? 0} °C',
        sensor_2_name: 'Vibration',
        sensor_2_value: '${motorData?.Vibration ?? 0} m/s²',
        sensor_3_name: 'Current',
        sensor_3_value: '${motorData?.Current ?? 0} A',
        days: motorData?.Predicted_fault ?? "None",
      ),
      MachineCardData(
        value: (beltDriverData?.Health ?? 0).toDouble(),
        name: 'BELT DRIVE',
        img: AppImages.motor_belt_Image,
        imgIcon: AppIcons.motor_belt_Icon,
        statusName: beltDriverData?.status ?? "None",
        sensor_1_name: 'Tension',
        sensor_1_value: '${beltDriverData?.Tension ?? 0} N',
        sensor_2_name: 'Alignment',
        sensor_2_value: '${beltDriverData?.Alignment ?? 0} mm',
        sensor_3_name: 'Speed',
        sensor_3_value: '${beltDriverData?.Speed ?? 0} RPM',
        days: beltDriverData?.Predicted_fault ?? "None",
      ),
      MachineCardData(
        value: (pumpData?.Health ?? 0).toDouble(),
        name: 'DC MOTOR',
        img: AppImages.motor_pump_Image,
        imgIcon: AppIcons.motor_pump_Icon,
        statusName: pumpData?.status ?? "None",
        sensor_1_name: 'Volt',
        sensor_1_value: '${pumpData?.Pressure_In ?? 0} V',
        sensor_2_name: 'Current',
        sensor_2_value: '${pumpData?.Flow_Rate ?? 0} A',
        sensor_3_name: 'Vibration',
        sensor_3_value: '${pumpData?.Temperature ?? 0} m/s²',
        days: pumpData?.Predicted_fault ?? "None",
      ),
    ];
    Provider.of<MachineProvider>(context, listen: false).setSystemCards(cards);
  }

  @override
  void initState() {
    super.initState();
    initPassword();
    loadData();
    _dataTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      loadData();
    });
  }

  @override
  void dispose() {
    _dataTimer?.cancel();
    super.dispose();
  }

  Future<void> initPassword() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("password")) {
      await prefs.setString("password", "2002");
    }
  }

  Future<void> openPage(int index) async {
    if (menuItems[index].title == "Advanced") {
      String? password = await loadPassword();

      bool result = await showPasswordDialog(context, password!);

      if (!result) return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  Future<String?> loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("password");
  }

  int selectedIndex = 0;
  Future<void> openAdvancedSetting(int index) async {
    if (menuItems[index].title == "Advanced") {
      String? savedPassword = await loadPassword();
      bool result = await showPasswordDialog(context, savedPassword ?? "2002");

      if (!result) return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  List<DrawerItem> get menuItems => [
    // HomeScreen
    DrawerItem(
      title: "Home",
      icon: Icons.home_rounded,
      page: HomeScreen(
        details: () {
          setState(() {
            // ignore: recursive_getters
            selectedIndex = menuItems.indexWhere((e) => e.title == "Details");
          });
        },
        alarm: () {
          setState(() {
            // ignore: recursive_getters
            selectedIndex = menuItems.indexWhere((e) => e.title == "Alarm");
          });
        },
        addCard: () {
          setState(() {
            // ignore: recursive_getters
            selectedIndex = menuItems.indexWhere((e) => e.title == "Add");
          });
        },
      ),
    ),
    // DetailsScreen
    DrawerItem(
      title: "Details",
      icon: Icons.data_saver_off_rounded,
      page: DetailsScreen(),
    ),
    // AlarmScreen
    DrawerItem(
      title: "Alarm",
      icon: Icons.notifications_active_rounded,
      page: AlarmScreen(),
    ),
    // AnalysisScreen
    DrawerItem(
      title: "Analysis",
      icon: Icons.analytics,
      page: AnalysisScreen(),
    ),
    // SettingScreen
    DrawerItem(
      title: "Data",
      icon: Icons.storage_rounded,
      page: ActuatorsLastDataScreen(),
    ),
    // AdminScreen
    DrawerItem(
      title: "Admin",
      icon: Icons.person,
      page: SettingScreen(
        advancedSettingOnTap: () async {
          String? savedPassword = await loadPassword();

          bool result = await showPasswordDialog(
            context,
            savedPassword ?? "2002",
          );

          if (result) {
            setState(() {
              // ignore: recursive_getters
              selectedIndex = menuItems.indexWhere(
                (e) => e.title == "Advanced",
              );
            });
          }
        },
      ),
    ),
    // SettingScreen
    DrawerItem(title: "Settings", icon: Icons.settings, page: SensorsScreen()),
    // AddScreen
    DrawerItem(
      title: "Add",
      icon: Icons.add,
      page: AddCardPage(
        page_after_finish: () {
          setState(() {
            // ignore: recursive_getters
            selectedIndex = menuItems.indexWhere((e) => e.title == "Home");
          });
        },
      ),
    ),
    // AdvancedSettingScreen
    DrawerItem(
      title: "Advanced",
      icon: Icons.settings_suggest,
      page: AdvancedSettingScreen(),
    ),
  ];
  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("password", password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Home_screen_background,
      body: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              data: menuItems,
              ontap: (index) {
                openPage(index);
              },
              selectedIndex: selectedIndex,
            ),

            // Expanded(
            //   child: IndexedStack(
            //     index: selectedIndex,
            //     children: menuItems.map((item) => item.page).toList(),
            //   ),
            // ),
            Expanded(child: menuItems[selectedIndex].page),
          ],
        ),
      ),
    );
  }
}
