import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Custom_Guage.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenMasterCustomCards extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Color card_color;
  final int value;
  final String name;
  final String img;
  // ignore: non_constant_identifier_names
  final String img_icon;
  final IconData icon;
  // ignore: non_constant_identifier_names
  final String status_name;
  const HomeScreenMasterCustomCards({
    super.key,
    // ignore: non_constant_identifier_names
    required this.card_color,
    required this.value,
    required this.name,
    required this.img,
    required this.icon,
    // ignore: non_constant_identifier_names
    required this.status_name,
    required this.img_icon,
  });

  @override
  State<HomeScreenMasterCustomCards> createState() =>
      _HomeScreenMasterCustomCardsState();
}

class _HomeScreenMasterCustomCardsState
    extends State<HomeScreenMasterCustomCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
      child: Container(
        width: ScreenArea.Width * 0.25,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: widget.card_color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: widget.card_color, width: 1),
        ),
        child: Column(
          children: [
            // upper contain
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: widget.card_color.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                border: Border.all(color: widget.card_color, width: 1),
              ),
              child: Row(
                children: [
                  Gap(20),
                  SimpleShadow(
                    opacity: 0.9,
                    color: widget.card_color,
                    offset: Offset(2, 2),
                    sigma: 10,
                    child: Image.asset(
                      widget.img_icon,
                      width: 50,
                      height: 50,
                      color: widget.card_color,
                    ),
                  ),
                  Gap(30),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Drawer_text_color,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // ignore: deprecated_member_use
                        color: widget.card_color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            widget.status_name,
                            style: TextStyle(
                              color: AppColors.Drawer_text_color,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                ],
              ),
            ),
            Gap(30),
            // image & Gauge in center
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(widget.img),
                  width: ScreenArea.Width * 0.15,
                  height: ScreenArea.Height * 0.15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Draw Health Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Health :  ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.Drawer_text_color,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "${widget.value} %",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: widget.card_color,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    // Draw Guage
                    Gap(30),
                    CustomGuage(
                      value: widget.value,
                      Guage_color: widget.card_color,
                      center: Text(
                        "${widget.value} %",
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                          color: widget.card_color.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Gap(10),
                  ],
                ),
                Gap(10),
              ],
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
