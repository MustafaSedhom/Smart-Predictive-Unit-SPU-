import 'package:flutter/material.dart';

class GetStateColor {
  static   Color getColor(String status) {
    switch (status.toUpperCase()) {
      case "NORMAL":
        return Colors.green;
      case "WARNING":
        return Colors.amber;
      case "ALERT":
      default:
        return Colors.red;
    }
  }
  
}