import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Drawer/widgets/Drawer_elments.dart';
import 'package:spu_linux_app/Screens/Drawer/widgets/Drawer_items.dart';
import 'package:spu_linux_app/Screens/Drawer/widgets/SPU_logo_in_Drawer.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class DrawerWidget extends StatefulWidget {
  final Function(int index)? ontap;
  final List<DrawerItem>? data;
  final int? selectedIndex;
  const DrawerWidget({super.key, required this.ontap, required this.data, required this.selectedIndex});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

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
                  text: item!.title,
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.Start_Button_color,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      "START SYSTEM",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  "SPU v1.0.0",
                  style: TextStyle(
                    // ignore: deprecated_member_use
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
