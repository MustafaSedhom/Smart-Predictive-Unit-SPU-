// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Alerts_data.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/widgets/Custom_list_view_container.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  AlertsData? alertsData;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final AlertData = await loadAlertsDataFromFile();

    if (!mounted) return;

    setState(() {
      alertsData = AlertData;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool alarm_list_is_empty = alertsData?.alerts.isEmpty ?? true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(10),
          // Appbar
          Row(
            children: [
              Gap(20),
              Text(
                "Last Alarms",
                style: CustomAppBarTextStyle.appbar_text_style(size: 25),
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
                                    onPressed: () async {
                                      await clearAlerts();
                                      setState(() {});
                                      // ignore: use_build_context_synchronously
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
                      itemCount: alertsData!.alerts.length,
                      itemBuilder: (context, index) {
                        final reversedList = alertsData!.alerts.reversed
                            .toList();
                        return CustomListViewContainer(
                          alarm: reversedList[index],
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
