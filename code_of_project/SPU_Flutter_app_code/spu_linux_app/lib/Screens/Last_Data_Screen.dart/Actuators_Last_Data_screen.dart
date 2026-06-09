// ignore_for_file: file_names, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_read.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_result.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Last_Data_Screen.dart/widgets/List_Last_Data.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class ActuatorsLastDataScreen extends StatefulWidget {
  const ActuatorsLastDataScreen({super.key});

  @override
  State<ActuatorsLastDataScreen> createState() =>
      _ActuatorsLastDataScreenState();
}

class _ActuatorsLastDataScreenState extends State<ActuatorsLastDataScreen> {
  StreamSubscription<FileSystemEvent>? fileWatcher;
  late Future<FileResult> fileFuture;

  String selectedType = "Motor";
  bool newestFirst = true;

  final List<String> dataTypes = ["Motor", "Pump", "Belt", "Health", "Alarm"];

  @override
  void initState() {
    super.initState();
    loadFile();
  }

  void loadFile() {
    String path = "";

    switch (selectedType) {
      case "Motor":
        path = FilePaths.motor_last_Data_path!;
        break;

      case "Pump":
        path = FilePaths.pump_last_Data_path!;
        break;

      case "Belt":
        path = FilePaths.belt_last_Data_path!;
        break;

      case "Health":
        path = FilePaths.health_last_Data_path!;
        break;

      case "Alarm":
        path = FilePaths.alarm_last_Data_path!;
        break;
    }

    setState(() {
      fileFuture = FileReader.readFile(path);
    });

    /// cancel old watcher
    fileWatcher?.cancel();

    /// watch new file
    fileWatcher = File(path).watch(events: FileSystemEvent.modify).listen((
      event,
    ) {
      if (event.type == FileSystemEvent.modify) {
        setState(() {
          fileFuture = FileReader.readFile(path);
        });
      }
    });
  }

  List<String> sortData(String rawData) {
    List<String> lines = rawData.split("\n");

    lines.removeWhere((e) => e.trim().isEmpty);

    /// get header
    String? header;

    for (var line in lines) {
      if (line.contains("Date,Time")) {
        header = line;
        break;
      }
    }

    /// remove header from data
    lines.removeWhere((e) => e.contains("Date,Time"));

    lines.sort((a, b) {
      try {
        final regex = RegExp(r'(\d{4}-\d{2}-\d{2}),(\d{2}:\d{2}:\d{2})');

        final matchA = regex.firstMatch(a);
        final matchB = regex.firstMatch(b);

        if (matchA == null || matchB == null) return 0;

        DateTime dateA = DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse("${matchA.group(1)} ${matchA.group(2)}");

        DateTime dateB = DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse("${matchB.group(1)} ${matchB.group(2)}");

        return newestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
      } catch (e) {
        return 0;
      }
    });

    /// put header first
    if (header != null) {
      lines.insert(0, header);
    }

    return lines;
  }

  @override
  void dispose() {
    fileWatcher?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Custom AppBar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Last System Data",
                    style: CustomAppBarTextStyle.appbar_text_style(size: 30),
                  ),
                  // sort button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        newestFirst = !newestFirst;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),

                        gradient: LinearGradient(
                          colors: newestFirst
                              ? [
                                  const Color(0xff22C55E),
                                  const Color(0xff16A34A),
                                ]
                              : [
                                  const Color(0xff3B82F6),
                                  const Color(0xff2563EB),
                                ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color:
                                (newestFirst
                                        ? const Color(0xff22C55E)
                                        : const Color(0xff3B82F6))
                                    .withOpacity(0.35),

                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedRotation(
                            turns: newestFirst ? 0 : 0.5,
                            duration: const Duration(milliseconds: 600),

                            child: const Icon(
                              Icons.sync_alt_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                newestFirst ? "Newest First" : "Oldest First",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                newestFirst
                                    ? "Latest data on top"
                                    : "Old data on top",

                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10),
              // Select Data Type
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataTypes.length,
                  itemBuilder: (context, index) {
                    final item = dataTypes[index];

                    final isSelected = item == selectedType;

                    return GestureDetector(
                      onTap: () {
                        selectedType = item;
                        loadFile();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff22C55E)
                              : Colors.white.withOpacity(0.08),

                          borderRadius: BorderRadius.circular(18),

                          border: Border.all(
                            color: isSelected
                                ? Colors.greenAccent
                                : Colors.white24,
                          ),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Image.asset(
                                AppIcons.Last_Data_from_Files_Icon,
                                width: 30,
                                color: isSelected
                                    ? AppColors.Home_screen_background
                                    : AppColors.Drawer_text_color,
                              ),
                              Gap(10),
                              Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.Home_screen_background
                                      : AppColors.Drawer_text_color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Gap(5),
              CustomDivider(),
              Gap(5),
              // Data
              Expanded(
                child: FutureBuilder<FileResult>(
                  future: fileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          "No Data",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                      );
                    }
                    final result = snapshot.data!;
                    if (!result.hasData) {
                      return Center(
                        child: Text(
                          result.message,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                      );
                    }
                    // real data
                    List<String> sortedData = sortData(result.rawData);
                    return ListLastData(data: sortedData);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
