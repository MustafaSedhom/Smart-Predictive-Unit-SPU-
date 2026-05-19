// ignore_for_file: deprecated_member_use
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Settings/Time_Date_analysis.dart';
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
  //////////////////////////////////////////////////////////
  /// DATE TIME

  DateTime selected_Date_Time_For_Start = DateTime.now();

  DateTime selected_Date_Time_For_End = DateTime.now();

  //////////////////////////////////////////////////////////
  /// COLOR

  Color color = Colors.deepPurpleAccent;

  //////////////////////////////////////////////////////////
  /// INIT STATE

  @override
  void initState() {
    super.initState();

    load_time_analysis();
  }

  //////////////////////////////////////////////////////////
  /// LOAD TIME ANALYSIS

  Future<void> load_time_analysis() async {
    //------------------------------------------------------
    // Load Data

    TimeDateAnalysis data = await loadTimeDateAnalysisFromFile();

    //------------------------------------------------------
    // Start Time

    if (data.TimeDate_Start.isNotEmpty) {
      selected_Date_Time_For_Start = DateTime.parse(data.TimeDate_Start);
    }

    //------------------------------------------------------
    // End Time

    if (data.TimeDate_End.isNotEmpty) {
      selected_Date_Time_For_End = DateTime.parse(data.TimeDate_End);
    }

    //------------------------------------------------------
    // Refresh

    if (mounted) {
      setState(() {});
    }
  }

  //////////////////////////////////////////////////////////
  /// SAVE TIME ANALYSIS

  Future<void> save_time_analysis() async {
    //------------------------------------------------------
    // Create Data

    TimeDateAnalysis data = TimeDateAnalysis(
      TimeDate_Start: selected_Date_Time_For_Start.toIso8601String(),

      TimeDate_End: selected_Date_Time_For_End.toIso8601String(),
    );

    //------------------------------------------------------
    // Save

    await saveTimeDateAnalysisToFile(data);

    //------------------------------------------------------
    // Message

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Analysis Time Saved")));
    }
  }

  //////////////////////////////////////////////////////////
  /// FORMAT TIME

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

  //////////////////////////////////////////////////////////
  /// BUILD

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////
    /// SHADOW

    List<BoxShadow> custom_shadow = [
      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),

      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),

      BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
    ];

    ////////////////////////////////////////////////////////

    return ChangesColorContainer(
      //----------------------------------------------------
      // SAVE KEY
      saveKey: "Analysis_Time_Color",

      //----------------------------------------------------
      // COLORS
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

      //----------------------------------------------------
      // CHANGE COLOR
      onColorChanged: (return_color) async {
        setState(() {
          color = return_color;
        });
      },

      //----------------------------------------------------
      // SHADOW
      shadow: custom_shadow,

      //----------------------------------------------------
      // CHILD
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          ////////////////////////////////////////////////////
          /// TITLE
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

          ////////////////////////////////////////////////////
          /// BOXES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              //////////////////////////////////////////////////
              /// START TIME BOX
              build_time_box(
                title: "Start Time",

                icon: AppIcons.Start_Time_Icon,

                selectedDateTime: selected_Date_Time_For_Start,

                onDateTap: () async {
                  DateTime? select = await Show_Bottom_Picker_For_Date(
                    context,
                    selected_Date_Time_For_Start,
                  );

                  setState(() {
                    selected_Date_Time_For_Start =
                        select ?? selected_Date_Time_For_Start;
                  });
                },

                onTimeTap: () async {
                  DateTime? select = await Show_Bottom_Picker_For_Time(
                    context,
                    selected_Date_Time_For_Start,
                  );

                  setState(() {
                    selected_Date_Time_For_Start =
                        select ?? selected_Date_Time_For_Start;
                  });
                },
              ),

              Gap(20),

              //////////////////////////////////////////////////
              /// END TIME BOX
              build_time_box(
                title: "End Time",

                icon: AppIcons.End_Time_Icon,

                selectedDateTime: selected_Date_Time_For_End,

                onDateTap: () async {
                  DateTime? select = await Show_Bottom_Picker_For_Date(
                    context,
                    selected_Date_Time_For_End,
                  );

                  setState(() {
                    selected_Date_Time_For_End =
                        select ?? selected_Date_Time_For_End;
                  });
                },

                onTimeTap: () async {
                  DateTime? select = await Show_Bottom_Picker_For_Time(
                    context,
                    selected_Date_Time_For_End,
                  );

                  setState(() {
                    selected_Date_Time_For_End =
                        select ?? selected_Date_Time_For_End;
                  });
                },
              ),
            ],
          ),

          Gap(25),

          ////////////////////////////////////////////////////
          /// SAVE BUTTON
          SizedBox(
            width: 200,
            height: 50,

            child: ElevatedButton.icon(
              onPressed: save_time_analysis,

              icon: Icon(Icons.save),

              label: Text("Save Analysis Time"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,

                foregroundColor: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// TIME BOX

  Widget build_time_box({
    required String title,
    required String icon,
    required DateTime selectedDateTime,
    required VoidCallback onDateTap,
    required VoidCallback onTimeTap,
  }) {
    return Container(
      padding: EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: color,

        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          ////////////////////////////////////////////////////
          /// TITLE
          Row(
            children: [
              Image.asset(icon, width: 30),

              Gap(10),

              Text(
                title,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Gap(25),

          ////////////////////////////////////////////////////
          /// DATE + TIME
          Container(
            padding: EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Column(
              children: [
                ////////////////////////////////////////////////
                /// DATE
                InkWell(
                  onTap: onDateTap,

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
                          "${selectedDateTime.day}/"
                          "${selectedDateTime.month}/"
                          "${selectedDateTime.year}",

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

                ////////////////////////////////////////////////
                /// TIME
                InkWell(
                  onTap: onTimeTap,

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
                          Format_Time(selectedDateTime),

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
        ],
      ),
    );
  }
}
