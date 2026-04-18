import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HomeScreenTitleCard extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String icon_img;
  // ignore: non_constant_identifier_names
  final String title_upper;
  // ignore: non_constant_identifier_names
  final String title_down;
  // ignore: non_constant_identifier_names
  final Color card_color;
  const HomeScreenTitleCard({
    super.key,
    // ignore: non_constant_identifier_names
    required this.icon_img,
    // ignore: non_constant_identifier_names
    required this.title_upper,
    // ignore: non_constant_identifier_names
    required this.title_down,
    // ignore: non_constant_identifier_names
    required this.card_color,
  });

  @override
  State<HomeScreenTitleCard> createState() => _HomeScreenTitleCardState();
}

class _HomeScreenTitleCardState extends State<HomeScreenTitleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: widget.card_color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleShadow(
              opacity: 0.9,
              color: widget.card_color,
              offset: Offset(2, 2),
              sigma: 10,
              child: Image.asset(
                widget.icon_img,
                width: 30,
                height: 30,
                color: widget.card_color,
              ),
            ),
            Gap(10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title_upper,
                  style: TextStyle(
                    color: widget.card_color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(5),
                Text(
                  widget.title_down,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
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
