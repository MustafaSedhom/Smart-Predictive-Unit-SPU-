import 'package:flutter/material.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenTitleCard extends StatefulWidget {
  final IconData icon;
  // ignore: non_constant_identifier_names
  final String title_upper;
  // ignore: non_constant_identifier_names
  final String title_down;
  // ignore: non_constant_identifier_names
  final Color title_upper_color;
  // ignore: non_constant_identifier_names
  final Color card_color;
  const HomeScreenTitleCard({
    super.key,
    required this.icon,
    required this.title_upper,
    required this.title_down,
    this.title_upper_color = AppColors.Drawer_text_color,
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
        width: ScreenArea.Width * 0.18,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // ignore: deprecated_member_use
          color: widget.card_color.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.icon, color: widget.card_color, size: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title_upper,
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.title_upper_color,
                  ),
                ),
                Text(
                  widget.title_down,
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.Drawer_text_color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
