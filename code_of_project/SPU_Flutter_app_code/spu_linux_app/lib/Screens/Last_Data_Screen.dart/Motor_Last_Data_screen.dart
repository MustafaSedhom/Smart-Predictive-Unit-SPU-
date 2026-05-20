// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_read.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_result.dart';

class MotorLastDataScreen extends StatefulWidget {
  const MotorLastDataScreen({super.key});

  @override
  State<MotorLastDataScreen> createState() => _MotorLastDataScreenState();
}

class _MotorLastDataScreenState extends State<MotorLastDataScreen> {
  late Future<FileResult> fileFuture;

  @override
  void initState() {
    super.initState();

    // fileFuture = MotorFileReader.readMotorFile();
    fileFuture = FileReader.readFile(FilePaths.motor_last_Data_path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motor Last Data")),
      body: FutureBuilder<FileResult>(
        future: fileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("No Data"));
          }

          final result = snapshot.data!;

          if (!result.hasData) {
            return Center(child: Text(result.message));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(result.rawData, style: const TextStyle(fontSize: 14)),
          );
        },
      ),
    );
  }
}
