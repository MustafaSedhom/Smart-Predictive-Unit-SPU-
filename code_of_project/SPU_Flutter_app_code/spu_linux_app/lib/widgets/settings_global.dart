// logo_notifier.dart
// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';

ValueNotifier<File?> logoNotifier = ValueNotifier(null);

enum Actuator{
  Motor,
  Belt,
  Pump
}