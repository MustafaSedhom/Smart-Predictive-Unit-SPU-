import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Custom_Guage.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenMasterCustomCards extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Color card_color;
  const HomeScreenMasterCustomCards({super.key, required this.card_color});

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
                  Gap(10),
                  Icon(
                    Icons.motorcycle_rounded,
                    size: 50,
                    color: AppColors.Drawer_text_color,
                  ),
                  Gap(20),
                  Text(
                    "MOTOR",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Drawer_text_color,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // ignore: deprecated_member_use
                        color: widget.card_color.withOpacity(0.6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            "NORMAL",
                            style: TextStyle(
                              color: AppColors.Drawer_text_color,
                              fontSize: 30,
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
            Gap(20),
            // image & Gauge in center
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage("assets/images/SEDHOM.jpg"),
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
                          "${82}%",
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
                    CustomGuage(value: 77, Guage_color: widget.card_color),
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
