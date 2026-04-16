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
    return Column(
      children: [
        Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Container(
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.Drawer_selected_color
                  : AppColors.Drawer_color,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Column(
              children: [
                const Gap(20),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        widget.icon,
                        color: widget.isSelected
                            ? AppColors.Drawer_icon_selected_color
                            : AppColors.Drawer_text_color,
                        size: 40,
                      ),
                      const Gap(10),
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: AppColors.Drawer_text_color,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: widget.onTap,
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
        Gap(5),
        const Divider(),
      ],
    );
  }
}
