// ignore_for_file: deprecated_member_use, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';
import 'package:spu_linux_app/widgets/selsect_date_and_time.dart';

class SetTimeAnalysisWidget extends StatefulWidget {
  SetTimeAnalysisWidget({super.key});

  @override
  State<SetTimeAnalysisWidget> createState() => _SetTimeAnalysisWidgetState();
}

class _SetTimeAnalysisWidgetState extends State<SetTimeAnalysisWidget> {
  DateTime selected_Date_Time_For_Start = DateTime.now();

  DateTime selected_Date_Time_For_End = DateTime.now();

  Color color = Colors.deepPurpleAccent;
  //---------------------------------------------------------
  String Format_Time(DateTime dateTime) {
    int hour = dateTime.hour;

    String period = hour >= 12 ? "PM" : "AM";

    int hour12 = hour % 12;

    if (hour12 == 0) {
      hour12 = 12;
    }

    String minute = dateTime.minute.toString().padLeft(2, '0');

    String second = dateTime.second.toString().padLeft(2, '0');

    return "$hour12:$minute:$second $period";
  }

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> custom_shadow = [
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
    ];
    return ChangesColorContainer(
      saveKey: "Analysis_Time_Color",
      colors: [
        Colors.green,
        Colors.blue,
        Colors.red,
        Colors.orange,
        Colors.purple,
        Colors.deepPurpleAccent,
        Colors.black,
        Colors.grey,
        Colors.blueGrey,
      ],
      onColorChanged: (return_color) async {
        setState(() {
          color = return_color;
        });
      },
      shadow: custom_shadow,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.time_Icon,
                width: 40,
                color: AppColors.Drawer_text_color,
              ),
              Gap(20),
              Text(
                "Analysis Time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(20),
          // Boxes to set time and date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // start time
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: custom_shadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //-------------------------------------------------
                    // Title
                    Row(
                      children: [
                        Image.asset(AppIcons.Start_Time_Icon, width: 30),
                        Gap(10),
                        Text(
                          " Start Time",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                    //-------------------------------------------------
                    // Selected Date
                    Container(
                      padding: EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            //-------------------------------------------------
                            // Date
                            InkWell(
                              onTap: () async {
                                DateTime? select =
                                    await Show_Bottom_Picker_For_Date(
                                      context,
                                      selected_Date_Time_For_Start,
                                    );
                                setState(() {
                                  selected_Date_Time_For_Start =
                                      select ?? selected_Date_Time_For_Start;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month, color: color),

                                    Gap(15),

                                    Text(
                                      "${selected_Date_Time_For_Start.day}/"
                                      "${selected_Date_Time_For_Start.month}/"
                                      "${selected_Date_Time_For_Start.year}",

                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(15),
                            //-------------------------------------------------
                            // Time
                            InkWell(
                              onTap: () async {
                                DateTime? select =
                                    await Show_Bottom_Picker_For_Time(
                                      context,
                                      selected_Date_Time_For_Start,
                                    );
                                setState(() {
                                  selected_Date_Time_For_Start =
                                      select ?? selected_Date_Time_For_Start;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, color: color),
                                    Gap(10),
                                    Text(
                                      Format_Time(selected_Date_Time_For_Start),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //-------------------------------------------------
                  ],
                ),
              ),
              Gap(20),
              // end time
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: custom_shadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //-------------------------------------------------
                    // Title
                    Row(
                      children: [
                        Image.asset(AppIcons.End_Time_Icon, width: 30),
                        Gap(10),
                        Text(
                          " End Time",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Gap(25),

                    //-------------------------------------------------
                    // Selected Date
                    Container(
                      padding: EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            //-------------------------------------------------
                            // Date
                            InkWell(
                              onTap: () async {
                                DateTime? select =
                                    await Show_Bottom_Picker_For_Date(
                                      context,
                                      selected_Date_Time_For_End,
                                    );
                                setState(() {
                                  selected_Date_Time_For_End =
                                      select ?? selected_Date_Time_For_End;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month, color: color),

                                    Gap(15),

                                    Text(
                                      "${selected_Date_Time_For_End.day}/"
                                      "${selected_Date_Time_For_End.month}/"
                                      "${selected_Date_Time_For_End.year}",

                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Gap(15),
                            //-------------------------------------------------
                            // Time
                            InkWell(
                              onTap: () async {
                                DateTime? select =
                                    await Show_Bottom_Picker_For_Time(
                                      context,
                                      selected_Date_Time_For_End,
                                    );
                                setState(() {
                                  selected_Date_Time_For_End =
                                      select ?? selected_Date_Time_For_End;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),

                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time, color: color),

                                    SizedBox(width: 10),

                                    Text(
                                      Format_Time(selected_Date_Time_For_End),

                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //-------------------------------------------------
                  ],
                ),
              ),
              //
            ],
          ),
        ],
      ),
    );
  }
}
