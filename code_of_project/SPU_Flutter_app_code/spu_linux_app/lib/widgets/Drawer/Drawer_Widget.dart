// ignore_for_file: non_constant_identifier_names, unused_local_variable, dead_code, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/widgets/Drawer/widgets/Drawer_elments.dart';
import 'package:spu_linux_app/widgets/Drawer/widgets/Drawer_items.dart';
import 'package:spu_linux_app/widgets/Drawer/widgets/SPU_logo_in_Drawer.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:window_manager/window_manager.dart';

class DrawerWidget extends StatefulWidget {
  final Function(int index)? ontap;
  final List<DrawerItem>? data;
  final int? selectedIndex;
  const DrawerWidget({
    super.key,
    required this.ontap,
    required this.data,
    required this.selectedIndex,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool is_max = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final items = widget.data;

    return Container(
      width: screenWidth * 0.17,
      height: screenHeight,
      color: AppColors.Drawer_color,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.15,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: SpuLogoInDrawer(),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items?[index];
                return DrawerElements(
                  icon: item!.icon,
                  text: item.title,
                  isSelected: widget.selectedIndex == index,
                  onTap: () {
                    setState(() {
                      widget.ontap!(index);
                    });
                  },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    bool isFull = await windowManager.isFullScreen();

                    bool newState = !isFull;

                    await windowManager.setFullScreen(newState);

                    setState(() {
                      is_max = newState;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: is_max
                          ? const Color(0xff22C55E)
                          : Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: is_max ? Colors.greenAccent : Colors.white24,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        is_max ? Icons.fullscreen_exit : Icons.fullscreen,
                        color: AppColors.Drawer_text_color,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Gap(5),
                // version
                Text(
                  "SPU  V2.1.7",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
                const Gap(5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
