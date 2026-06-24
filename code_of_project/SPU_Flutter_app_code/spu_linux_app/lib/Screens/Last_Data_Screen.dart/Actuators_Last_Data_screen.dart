// ignore_for_file: deprecated_member_use

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
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class ActuatorsLastDataScreen extends StatefulWidget {
  const ActuatorsLastDataScreen({super.key});

  @override
  State<ActuatorsLastDataScreen> createState() =>
      _ActuatorsLastDataScreenState();
}

class _ActuatorsLastDataScreenState extends State<ActuatorsLastDataScreen> {
  StreamSubscription<FileSystemEvent>? fileWatcher;
  Future<FileResult>? fileFuture;
  String selectedType = "Motor";
  bool newestFirst = true;

  final List<String> dataTypes = [
    "AC Motor",
    "DC Motor",
    "Belt",
    "Health",
    "Alarm",
  ];

  final Map<String, String?> paths = {
    "AC Motor": FilePaths.Ac_motor_last_Data_path,
    "DC Motor": FilePaths.Dc_motor_last_Data_path,
    "Belt": FilePaths.belt_last_Data_path,
    "Health": FilePaths.health_last_Data_path,
    "Alarm": FilePaths.alarm_last_Data_path,
  };

  @override
  void initState() {
    super.initState();
    loadFile();
  }

  void loadFile() {
    final path = paths[selectedType] ?? "";

    if (path.isEmpty) {
      setState(() {
        fileFuture = Future.value(
          FileResult(hasData: false, rawData: "", message: "Invalid file path"),
        );
      });
      return;
    }

    setState(() {
      fileFuture = FileReader.readFile(path);
    });

    fileWatcher?.cancel();
    final file = File(path);

    if (file.existsSync()) {
      fileWatcher = file.watch().listen((event) {
        if (!mounted) return;
        setState(() {
          fileFuture = FileReader.readFile(path);
        });
      });
    }
  }

  List<String> sortData(String rawData) {
    List<String> lines = rawData.split("\n");
    lines.removeWhere((e) => e.trim().isEmpty);

    String? header;
    for (var line in lines) {
      if (line.contains("Date,Time")) {
        header = line;
        break;
      }
    }

    lines.removeWhere((e) => e.contains("Date,Time"));

    lines.sort((a, b) {
      try {
        final regex = RegExp(r'(\d{4}-\d{2}-\d{2}),(\d{2}:\d{2}:\d{2})');
        final matchA = regex.firstMatch(a);
        final matchB = regex.firstMatch(b);

        if (matchA == null || matchB == null) return 0;

        final dateA = DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse("${matchA.group(1)} ${matchA.group(2)}");
        final dateB = DateFormat(
          "yyyy-MM-dd HH:mm:ss",
        ).parse("${matchB.group(1)} ${matchB.group(2)}");

        return newestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
      } catch (_) {
        return 0;
      }
    });

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
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'SYSTEM HISTORICAL DATA',
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
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        newestFirst = !newestFirst;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1000),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: newestFirst
                            ? const Color(0xFF00F5D4).withOpacity(0.15)
                            : const Color(0xFF3B82F6).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: newestFirst
                              ? const Color(0xFF00F5D4)
                              : const Color(0xFF3B82F6),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.swap_vert_rounded,
                            size: 16,
                            color: newestFirst
                                ? const Color(0xFF00F5D4)
                                : const Color(0xFF3B82F6),
                          ),
                          const Gap(6),
                          Text(
                            newestFirst ? "Newest" : "Oldest",
                            style: TextStyle(
                              color: newestFirst
                                  ? const Color(0xFF00F5D4)
                                  : const Color(0xFF3B82F6),
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 0.0),
        child: Column(
          children: [
            SizedBox(
              height: 46,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: dataTypes.length,
                itemBuilder: (context, index) {
                  final item = dataTypes[index];
                  final isSelected = item == selectedType;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected && selectedType != item) {
                          setState(() {
                            selectedType = item;
                          });
                          loadFile();
                        }
                      },
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(0xff22C55E)
                            : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                      avatar: Image.asset(
                        AppIcons.Last_Data_from_Files_Icon,
                        width: 18,
                        color: isSelected
                            ? const Color(0xff22C55E)
                            : Colors.white54,
                      ),
                      selectedColor: const Color(0xFF16192B),
                      backgroundColor: const Color(0xFF16192B),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xff22C55E)
                            : Colors.white12,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Gap(10),
            const CustomDivider(),
            const Gap(10),
            Expanded(
              child: fileFuture == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00F5D4),
                      ),
                    )
                  : FutureBuilder<FileResult>(
                      future: fileFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF00F5D4),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: const TextStyle(
                                color: Color(0xFFFF5A5F),
                                fontSize: 14,
                              ),
                            ),
                          );
                        }

                        final result = snapshot.data;
                        if (result == null || !result.hasData) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open_rounded,
                                  size: 48,
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                const Gap(12),
                                Text(
                                  result?.message ?? "No Data Available",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        final sortedData = sortData(result.rawData);
                        return ListLastData(data: sortedData);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
