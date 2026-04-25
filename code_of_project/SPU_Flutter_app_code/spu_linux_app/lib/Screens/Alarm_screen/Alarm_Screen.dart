import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Data_Type/Alarm_Data.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/widgets/Custom_list_view_container.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AlarmScreen extends StatefulWidget {
  AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // ignore: non_constant_identifier_names
  final List<AlarmData> alarm_list = [
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.thermostat,
      Date: "22 / 02 / 2006",
      Time: "11 : 08 : 57",
      value: "12 °C",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_belt_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.bolt,
      Date: "22 / 02 / 2006",
      Time: "11 : 03 : 01",
      value: "100 A",
    ),
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_belt_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_pump_Icon,
      Problem_Icon: Icons.thermostat,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "78 °C",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, non_constant_identifier_names
    bool alarm_list_is_empty = alarm_list.isEmpty;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Gap(10),
          // Appbar
          Row(
            children: [
              Gap(20),
              Text(
                "Last Alarms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              // clear button
              TextButton(
                onPressed: () {
                  setState(() {
                    (alarm_list_is_empty)
                        ? Gap(0)
                        : showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                icon: Icon(
                                  Icons.cleaning_services,
                                  color: AppColors.Drawer_text_color,
                                ),
                                backgroundColor: AppColors.Drawer_color,
                                content: Text(
                                  "Are you sure you want to clear Last Alarms?",
                                  style: TextStyle(
                                    color: AppColors.Drawer_text_color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: AppColors.Drawer_text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        alarm_list.clear();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        color: AppColors.Drawer_text_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  side: BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close_rounded),
                    SizedBox(width: 6),
                    Text("Clear"),
                  ],
                ),
              ),
              Gap(20),
            ],
          ),
          Gap(5),
          CustomDivider(),
          // ListView Sensors
          (alarm_list_is_empty)
              ? Text(
                  "No Alarms",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      itemCount: alarm_list.length,
                      itemBuilder: (context, index) {
                        return CustomListViewContainer(
                          alarm: alarm_list[index],
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
