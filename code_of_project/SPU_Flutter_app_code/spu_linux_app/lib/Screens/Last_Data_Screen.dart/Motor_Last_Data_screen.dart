// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

import 'package:spu_linux_app/DataBase/file_paths.dart';

////////////////////////////////////////////////////////////
/// RESULT MODEL

class FileResult {
  final bool hasData;
  final String message;
  final String rawData;

  FileResult({
    required this.hasData,
    required this.message,
    required this.rawData,
  });
}

////////////////////////////////////////////////////////////
/// FILE READER

class MotorFileReader {
  static Future<FileResult> readMotorFile() async {
    try {
      final path = FilePaths.motor_last_Data_path;

      if (path == null || path.isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty Path)",
          rawData: "",
        );
      }

      final file = File(path);

      if (!await file.exists()) {
        return FileResult(
          hasData: false,
          message: "No Data (File Not Found)",
          rawData: "",
        );
      }

      final data = await file.readAsString();

      if (data.isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty File)",
          rawData: "",
        );
      }

      return FileResult(hasData: true, message: "Success", rawData: data);
    } catch (e) {
      return FileResult(hasData: false, message: "Error: $e", rawData: "");
    }
  }
}

////////////////////////////////////////////////////////////
/// UI SCREEN

class MotorLastDataScreen extends StatefulWidget {
  const MotorLastDataScreen({super.key});

  @override
  State<MotorLastDataScreen> createState() => _MotorLastDataScreenState();
}

class _MotorLastDataScreenState extends State<MotorLastDataScreen> {
  //////////////////////////////////////////////////////////
  /// DATA

  List<List<dynamic>> csvData = [];
  bool isLoading = true;
  String message = "";

  //////////////////////////////////////////////////////////
  /// INIT

  @override
  void initState() {
    super.initState();
    loadMotorData();
  }

  //////////////////////////////////////////////////////////
  /// LOAD DATA

  Future<void> loadMotorData() async {
    setState(() {
      isLoading = true;
    });

    final result = await MotorFileReader.readMotorFile();

    if (result.hasData) {
      final List<List<dynamic>> data = const CsvToListConverter().convert(
        result.rawData,
      );

      setState(() {
        csvData = data;
        isLoading = false;
      });
    } else {
      setState(() {
        message = result.message;
        isLoading = false;
      });
    }
  }

  //////////////////////////////////////////////////////////
  /// UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Motor Last Data"),
        actions: [
          IconButton(
            onPressed: () {
              loadMotorData();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : csvData.isEmpty
          ? Center(
              child: Text(
                message.isEmpty ? "No Data" : message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: csvData.length,

              itemBuilder: (context, index) {
                final row = csvData[index];

                return Card(
                  margin: const EdgeInsets.all(10),

                  child: ListTile(
                    leading: const Icon(Icons.settings),

                    title: Text(
                      row.isNotEmpty ? row[0].toString() : "Empty Row",
                    ),

                    subtitle: Text(row.toString()),
                  ),
                );
              },
            ),
    );
  }
}
