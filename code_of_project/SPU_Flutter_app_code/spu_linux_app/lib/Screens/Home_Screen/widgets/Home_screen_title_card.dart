import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenTitleCard extends StatefulWidget {
  final IconData icon;
  // ignore: non_constant_identifier_names
  final String title_upper;
  // ignore: non_constant_identifier_names
  final String title_down;
  // ignore: non_constant_identifier_names
  final Color card_color;
  const HomeScreenTitleCard({
    super.key,
    required this.icon,
    required this.title_upper,
    required this.title_down,
    required this.card_color,
  });

  @override
  State<HomeScreenTitleCard> createState() => _HomeScreenTitleCardState();
}

class _HomeScreenTitleCardState extends State<HomeScreenTitleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          // color: Color(0xFF1A1F26),
          // ignore: deprecated_member_use
          color: widget.card_color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.card_color,
              size: 50,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  // ignore: deprecated_member_use
                  color: widget.card_color.withOpacity(0.5),
                ),
              ],
            ),
            Gap(20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title_upper,
                  style: TextStyle(
                    color: widget.card_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(5),
                Text(
                  widget.title_down,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Gap(40),
          ],
        ),
      ),
    );
  }
}
