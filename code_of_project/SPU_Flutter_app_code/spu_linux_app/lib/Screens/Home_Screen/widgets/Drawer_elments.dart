import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class DrawerElements extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final Function() onTap;

  const DrawerElements({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<DrawerElements> createState() => _DrawerElementsState();
}

class _DrawerElementsState extends State<DrawerElements> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    double screen_height = MediaQuery.of(context).size.height;
    // ignore: non_constant_identifier_names
    double screen_width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),

          decoration: BoxDecoration(
            color: widget.isSelected
                // ignore: deprecated_member_use
                ? AppColors.Drawer_selected_color.withOpacity(0.7)
                : AppColors.Drawer_color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.Drawer_text_color, width: 2),
          ),
          child: Center(
            child: Column(
              children: [
                ListTile(
                  title: (screen_width < 1000)
                      ? Icon(
                          widget.icon,
                          color: widget.isSelected
                              ? AppColors.Drawer_icon_selected_color
                              : AppColors.Drawer_text_color,
                          size: screen_width * 0.05,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              widget.icon,
                              color: widget.isSelected
                                  ? AppColors.Drawer_icon_selected_color
                                  : AppColors.Drawer_text_color,
                              size: screen_width * 0.02,
                            ),
                            Gap(screen_height * 0.01),
                            Expanded(
                              child: Text(
                                widget.text,
                                style: TextStyle(
                                  color: widget.isSelected
                                      ? AppColors.Drawer_icon_selected_color
                                      : AppColors.Drawer_text_color,
                                  fontSize: screen_width * 0.01,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                  onTap: widget.onTap,
                ),
                // (screen_width > 1000) ? Gap(screen_height * 0.001) : Gap(0),
                Gap(screen_height * 0.001),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
