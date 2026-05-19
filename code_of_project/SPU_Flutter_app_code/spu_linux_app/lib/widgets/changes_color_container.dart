// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangesColorContainer extends StatefulWidget {
  //---------------------------------------------------------
  // Child Widget

  final Widget child;

  //---------------------------------------------------------
  // Custom Colors List

  final List<Color> colors;

  //---------------------------------------------------------
  // Shadows

  final List<BoxShadow>? shadow;

  //---------------------------------------------------------
  // Save Key

  final String saveKey;

  //---------------------------------------------------------
  // Return Selected Color

  final Function(Color selectedColor)? onColorChanged;

  //---------------------------------------------------------

  const ChangesColorContainer({
    super.key,
    required this.child,
    required this.colors,
    required this.saveKey,
    this.onColorChanged,
    this.shadow,
  });

  @override
  State<ChangesColorContainer> createState() => _ChangesColorContainerState();
}

class _ChangesColorContainerState extends State<ChangesColorContainer> {
  //---------------------------------------------------------
  // Current Color Index

  int currentColorIndex = 0;

  //---------------------------------------------------------
  // Init State

  @override
  void initState() {
    super.initState();

    //---------------------------------------------------------
    // Load Saved Color

    load_saved_color();
  }

  //---------------------------------------------------------
  // Load Saved Color

  Future<void> load_saved_color() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //---------------------------------------------------------
    // Get Saved Color

    int? savedColorValue = prefs.getInt(widget.saveKey);

    //---------------------------------------------------------
    // If Saved Color Exists

    if (savedColorValue != null) {
      int index = widget.colors.indexWhere(
        (color) => color.value == savedColorValue,
      );

      //---------------------------------------------------------
      // If Color Found

      if (index != -1) {
        setState(() {
          currentColorIndex = index;
        });

        //-----------------------------------------------------
        // Return Loaded Color

        widget.onColorChanged?.call(widget.colors[currentColorIndex]);
      }
    } else {
      //---------------------------------------------------------
      // Save First Color Automatically

      await prefs.setInt(widget.saveKey, widget.colors[0].value);
    }
  }

  //---------------------------------------------------------
  // Save Color

  Future<void> save_color(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(widget.saveKey, color.value);
  }

  //---------------------------------------------------------
  // Change Color

  void change_color() async {
    //---------------------------------------------------------
    // Protection

    if (widget.colors.isEmpty) return;

    setState(() {
      currentColorIndex++;

      //---------------------------------------------------------
      // Loop Colors

      if (currentColorIndex >= widget.colors.length) {
        currentColorIndex = 0;
      }
    });

    //---------------------------------------------------------
    // Current Selected Color

    Color selectedColor = widget.colors[currentColorIndex];

    //---------------------------------------------------------
    // Save Color

    await save_color(selectedColor);

    //---------------------------------------------------------
    // Return Selected Color

    widget.onColorChanged?.call(selectedColor);
  }

  //---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //---------------------------------------------------------
    // Current Color

    final Color currentColor = widget.colors.isNotEmpty
        ? widget.colors[currentColorIndex]
        : Colors.grey;

    //---------------------------------------------------------

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: currentColor,

        borderRadius: const BorderRadius.all(Radius.circular(25)),

        boxShadow: widget.shadow,
      ),

      //---------------------------------------------------------
      // Stack
      child: Stack(
        children: [
          //-----------------------------------------------------
          // Child Widget
          widget.child,

          //-----------------------------------------------------
          // Change Color Button
          Positioned(
            top: 0,
            right: 0,

            child: GestureDetector(
              onTap: change_color,

              child: CircleAvatar(
                radius: 16,

                backgroundColor: Colors.white,

                child: Icon(Icons.color_lens, color: currentColor, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
