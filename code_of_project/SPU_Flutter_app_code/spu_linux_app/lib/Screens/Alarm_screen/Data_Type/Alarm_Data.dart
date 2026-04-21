import 'package:flutter/cupertino.dart';

class AlarmData {
  // ignore: non_constant_identifier_names
  final String Icon;
  // ignore: non_constant_identifier_names
  final String title;
  // ignore: non_constant_identifier_names
  final String value;
  // ignore: non_constant_identifier_names
  final IconData Problem_Icon;
  // ignore: non_constant_identifier_names
  final String Date;
  // ignore: non_constant_identifier_names
  final String Time;

  AlarmData({
    // ignore: non_constant_identifier_names
    required this.Icon,
    // ignore: non_constant_identifier_names
    required this.title,
    // ignore: non_constant_identifier_names
    required this.Problem_Icon,
    // ignore: non_constant_identifier_names
    required this.Date,
    // ignore: non_constant_identifier_names
    required this.Time, required this.value,
  });
}
