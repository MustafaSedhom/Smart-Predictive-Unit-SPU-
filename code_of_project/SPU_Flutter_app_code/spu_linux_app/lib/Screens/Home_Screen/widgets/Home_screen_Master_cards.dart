import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Belt_Driver_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Motor_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Pump_Card_Data.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';

class HomeScreenMasterCard extends StatefulWidget {
  const HomeScreenMasterCard({super.key});

  @override
  State<HomeScreenMasterCard> createState() => _HomeScreenMasterCardState();
}

class _HomeScreenMasterCardState extends State<HomeScreenMasterCard> {
  Motor? motor;
  BeltDriver? beltDriver;
  Pump? pump;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final motorData = await loadMotorFromFile();
    final pumpData = await loadPumpFromFile();
    final beltDriverData = await loadBeltDriverFromFile();

    if (!mounted) return;

    setState(() {
      motor = motorData;
      pump = pumpData;
      beltDriver = beltDriverData;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          HomeScreenMasterCustomCards(
            value: motor?.Health ?? 0,
            name: 'MOTOR',
            img: "assets/images/motor.png",
            img_icon: "assets/Icons/motor_icon.png",
            icon: Icons.macro_off,
            status_name: motor?.status ?? "None",
            txt_1_up: 'Temperature',
            txt_1_down: '${motor?.Temperature ?? 0} \u00B0C',
            txt_2_up: 'Vibration',
            txt_2_down: '${motor?.Vibration ?? 0} mm/s',
            txt_3_up: 'Current',
            txt_3_down: '${motor?.Current ?? 0} A',
            Days: motor?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
          const Gap(20),
          HomeScreenMasterCustomCards(
            value: beltDriver?.Health ?? 0,
            name: 'BELT DRIVE',
            img: "assets/images/motor_belt.png",
            img_icon: "assets/Icons/motor_belt_icon.png",
            icon: Icons.macro_off,
            status_name: beltDriver?.status ?? "None",
            txt_1_up: 'Tension',
            txt_1_down: '${beltDriver?.Tension ?? 0} N',
            txt_2_up: 'Alignment',
            txt_2_down: '${beltDriver?.Alignment ?? 0} mm',
            txt_3_up: 'Speed',
            txt_3_down: '${beltDriver?.Speed ?? 0} RPM',
            Days: beltDriver?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
          const Gap(20),
          HomeScreenMasterCustomCards(
            value: pump?.Health ?? 0,
            name: 'PUMP',
            img: "assets/images/motor_pump.png",
            img_icon: "assets/Icons/motor_pump_icon.png",
            icon: Icons.macro_off,
            status_name: pump?.status ?? "None",
            txt_1_up: 'Pressure In',
            txt_1_down: '${pump?.Pressure_In ?? 0} bar',
            txt_2_up: 'Flow Rate',
            txt_2_down: '${pump?.Flow_Rate ?? 0} L/min',
            txt_3_up: 'Temperature',
            txt_3_down: '${pump?.Temperature ?? 0} \u00B0C',
            Days: pump?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
        ],
      ),
    );
  }
}
